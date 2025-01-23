
using backend.Configuration;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Text.Json;

namespace backend.Services {
  public interface IGeocodingService {
    Task<GeocodingResponse?> GetCityFromLatLongAsync(float latitude, float longitude);

    Task<GeocodingResponse?> GetCityFromIpAsync(string ipAddress);
  }

  public class GeocodingService : IGeocodingService {
    private readonly GoogleMapsConfig googleMapsConfig;
    private readonly ILogger<GeocodingService> logger;
    public GeocodingService(IOptions<GoogleMapsConfig> _googleMapsOptions, ILogger<GeocodingService> _logger) {
      googleMapsConfig = _googleMapsOptions.Value;
      logger = _logger;
    }
    public async Task<GeocodingResponse?> GetCityFromLatLongAsync(float latitude, float longitude) {
      var url = $"https://maps.googleapis.com/maps/api/geocode/json?latlng={latitude},{longitude}&key={googleMapsConfig.ApiKey}";

      string? city = null;
      string? state = null;
      string? stateCode = null;
      string? country = null;
      string? countryCode = null;

      using (var client = new HttpClient()) {
        var response = await client.GetStringAsync(url);
        var json = JObject.Parse(response);

        var results = json?["results"];
        if (results != null && results.HasValues) {
          foreach (var result in results) {
            var components = result["address_components"];
            if (components != null && components.HasValues) {
              foreach (var component in components) {
                if (component != null) {
                  var types = component["types"];
                  if (types != null && types.HasValues) {
                    foreach (var type in types) {
                      if (type.ToString() == "locality") {
                        city = component["short_name"]?.ToString();
                      }
                      if (type.ToString() == "country") {
                        country = component["long_name"]?.ToString();
                        countryCode = component["short_name"]?.ToString();
                      }
                      if (type.ToString() == "administrative_area_level_1") {
                        state = component["long_name"]?.ToString();
                        stateCode = component["short_name"]?.ToString();
                      }
                    }
                  }
                  if (city != null && state != null && stateCode != null && country != null && countryCode != null) {
                    break;
                  }
                }
              }
              if (city != null && state != null && stateCode != null && country != null && countryCode != null) {
                break;
              }
            }
          }
        }
        if (city != null && state != null && stateCode != null && country != null && countryCode != null) {
          return new GeocodingResponse {
            City = city,
            State = state,
            StateCode = stateCode,
            Country = country,
            CountryCode = countryCode,
          };
        }
        return null;
      }
    }

    public async Task<GeocodingResponse?> GetCityFromIpAsync(string ipAddress) {
      string url = $"https://www.googleapis.com/geolocation/v1/geolocate?key={googleMapsConfig.ApiKey}";
      var requestBody = new {
        considerIp = true,
      };
      var requestBodyJson = JsonSerializer.Serialize(requestBody);

      var requestMessage = new HttpRequestMessage(HttpMethod.Post, url) {
        Content = new StringContent(requestBodyJson, Encoding.UTF8, "application/json"),
      };

      requestMessage.Headers.Add("X-Forwarded-For", ipAddress);

      using (var client = new HttpClient()) {
        var response = await client.SendAsync(requestMessage);
        if (!response.IsSuccessStatusCode) {
          return null;
        }
        var responseText = await response.Content.ReadAsStringAsync();
        var json = JObject.Parse(responseText);

        var location = json?["location"];
        if (location != null) {
          float latitude;
          float longitude;
          if (float.TryParse(location["lat"]?.ToString(), out latitude) && float.TryParse(location["lng"]?.ToString(), out longitude)) {
            return await GetCityFromLatLongAsync(latitude, longitude);
          }
        }

        return null;
      }
    }
  }
}

public class GeocodingResponse {
  public required string City { get; set; }
  public required string Country { get; set; }
  public required string CountryCode { get; set; }
  public required string State { get; set; }
  public required string StateCode { get; set; }
}
