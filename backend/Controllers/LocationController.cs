using backend.Db;
using backend.Models;
using backend.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers {
  [ApiController]
  [Route("api/[controller]")]
  public class LocationController : ControllerBase {
    private readonly ILogger<DataController> _logger;
    private readonly ApplicationDbContext _dbContext;
    private readonly IGeocodingService _geocodingService;

    public LocationController(ILogger<DataController> logger, ApplicationDbContext dbContext, IGeocodingService geocodingService) {
      _logger = logger;
      _dbContext = dbContext;
      _geocodingService = geocodingService;
    }

    [HttpGet("companies/flat")]
    public async Task<ActionResult<LocationAndCompanyModel>> GetLocationsAndCompaniesFlat() {
      var locations = await (
        from l in _dbContext.Locations
        join c in _dbContext.ElectricityCompanies
          on l.Id equals c.LocationId
        orderby l.City, l.Country
        select new LocationAndCompany {
          Location = new Location {
            Id = l.Id,
            City = l.City,
            State = l.State,
            StateCode = l.StateCode,
            Country = l.Country,
            CountryCode = l.CountryCode,
          },
          Company = new PeakDataElecitricityCompanyMinimal {
            Id = c.Id,
            Name = c.Name,
            Url = c.Url,
          }
        }
      ).ToListAsync();

      return new LocationAndCompanyModel {
        LocationsAndCompanies = locations,
      };
    }

    [HttpGet("current")]
    public async Task<ActionResult<Location?>> GetCurrentLocation(float? latitude, float? longitude) {
      GeocodingResponse? geoLocationResponse = null;
      var ipAddress = HttpContext.Connection.RemoteIpAddress?.MapToIPv4().ToString();
      if (latitude != null && longitude != null) {
        geoLocationResponse = await _geocodingService.GetCityFromLatLongAsync(latitude.Value, longitude.Value);
      }

      if (geoLocationResponse == null && ipAddress != null) {
        geoLocationResponse = await _geocodingService.GetCityFromIpAsync(ipAddress);
      }

      if (geoLocationResponse == null) {
        return Ok(null);
      }

      return await (
        from l in _dbContext.Locations
        where l.City == geoLocationResponse.City && l.CountryCode == geoLocationResponse.CountryCode
        select new Location {
          Id = l.Id,
          City = l.City,
          State = l.State,
          StateCode = l.StateCode,
          Country = l.Country,
          CountryCode = l.CountryCode,
        }
      ).FirstOrDefaultAsync();
    }
  }
}
