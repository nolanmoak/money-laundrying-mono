using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {
        // Simple GET request
        [HttpGet("hello")]
        public IActionResult GetTestMessage()
        {
            return Ok("Hello, welcome to the API!");
        }
    }
}
