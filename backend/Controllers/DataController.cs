using backend.Db;
using backend.Models;
using backend.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers {
  [ApiController]
  [Route("api/[controller]")]
  public class DataController : Controller {
    private static readonly List<int> winterMonths = [11, 12, 1, 2, 3, 4];
    private readonly ILogger<DataController> _logger;
    private readonly ApplicationDbContext _dbContext;
    private readonly IGeocodingService _geocodingService;

    public DataController(ILogger<DataController> logger, ApplicationDbContext dbContext, IGeocodingService geocodingService) {
      _logger = logger;
      _dbContext = dbContext;
      _geocodingService = geocodingService;
    }

    [HttpGet()]
    public async Task<ActionResult<DataModel>> Get(float? latitude, float? longitude) {
      var dateTime = DateTime.Now;
      GeocodingResponse? geoLocationResponse = null;

      var ipAddress = HttpContext.Connection.RemoteIpAddress?.MapToIPv4().ToString();

      if (latitude != null && longitude != null) {
        geoLocationResponse = await _geocodingService.GetCityFromLatLongAsync(latitude.Value, longitude.Value);
      }

      if (geoLocationResponse == null && ipAddress != null) {
        geoLocationResponse = await _geocodingService.GetCityFromIpAsync(ipAddress);
      }

      if (geoLocationResponse == null) {
        return NotFound();
      }
      var season = GetCurrentSeason(dateTime);

      var data = await (
        from l in _dbContext.Locations
        where l.City == geoLocationResponse.City && l.CountryCode == geoLocationResponse.CountryCode
        select new DataModel {
          City = l.City,
          State = l.State,
          StateCode = l.StateCode,
          Country = l.Country,
          CountryCode = l.CountryCode,
          ElectricityCompanies = (
            from elec in l.ElectricityCompanies
            select new PeakDataElectricityCompany() {
              Name = elec.Name,
              Url = elec.Url,
              Days = (
                from s in elec.Seasons
                join d in _dbContext.ElectricityCompanySeasonDays
                  on s.Id equals d.SeasonId
                where s.Season == season
                orderby d.Day, d.Id
                select new PeakDataDay {
                  DayOfWeek = d.Day,
                  Entries = (
                    from e in d.Entries
                    select new PeakDataEntry {
                      Type = e.Type,
                      Ranges = (
                        from r in e.Ranges
                        select new PeakDataHourRange {
                          Start = r.StartHour,
                          End = r.EndHour,
                        }
                      ),
                    }
                  ),
                }
              ),
            }
          ),

        }
      ).FirstOrDefaultAsync();

      if (data == null) {
        return NotFound();
      }

      return data;
    }

    private PeakDataSeason GetCurrentSeason(DateTime dateTime) {
      if (winterMonths.Contains(dateTime.Month)) {
        return PeakDataSeason.Winter;
      }
      return PeakDataSeason.Summer;
    }
  }
}
