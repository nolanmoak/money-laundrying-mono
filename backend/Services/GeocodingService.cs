
using backend.Configuration;
using Microsoft.Extensions.Options;

namespace backend.Services {
  public interface IGeocodingService {
    Task<string> GetCityFromLatLong(float latitude, float longitude);
  }

  public class GeocodingService : IGeocodingService {
    private readonly GoogleMapsConfig googleMapsConfig;
    private readonly ILogger<GeocodingService> logger;
    public GeocodingService(IOptions<GoogleMapsConfig> _googleMapsOptions, ILogger<GeocodingService> _logger) {
      googleMapsConfig = _googleMapsOptions.Value;
      logger = _logger;
    }
    public async Task<string> GetCityFromLatLong(float latitude, float longitude) {
      var url = $"https://maps.googleapis.com/maps/api/geocode/json?latlng={latitude},{longitude}&key={googleMapsConfig.ApiKey}";

      using (var client = new HttpClient()) {
        var response = await client.GetStringAsync(url);
        logger.LogInformation(response);
        return response;
      }
    }
  }

  public class GoogleGeocodingApiResponse {
    public required string City { get; set; }
  }
}
