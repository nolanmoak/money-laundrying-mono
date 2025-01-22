using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers {
  [ApiController]
  [Route("api/[controller]")]
  public class DataController : Controller {
    private static readonly List<int> winterMonths = [11, 12, 1, 2, 3, 4];
    private readonly ILogger<DataController> _logger;

    public DataController(ILogger<DataController> logger) {
      _logger = logger;
    }

    [HttpGet()]
    public ActionResult<DataModel> Get() {
      var dateTime = DateTime.Now;
      if (winterMonths.Contains(dateTime.Month)) {
        return new WinterDataModel().GetDataModel();
      }
      return new SummerDataModel().GetDataModel();
    }
  }
}
