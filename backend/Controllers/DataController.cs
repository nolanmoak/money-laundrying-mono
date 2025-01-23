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

    public DataController(ILogger<DataController> logger, ApplicationDbContext dbContext) {
      _logger = logger;
      _dbContext = dbContext;
    }

    [HttpGet()]
    public async Task<ActionResult<DataModel>> Get(string companyId) {
      var dateTime = DateTime.Now;
      var season = GetCurrentSeason(dateTime);

      var data = await (
        from c in _dbContext.ElectricityCompanies
        where c.Id == companyId
        select new DataModel {
          Days = (
            from s in c.Seasons
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
