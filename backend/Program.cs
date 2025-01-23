using backend.Configuration;
using backend.Db;
using backend.Services;
using Microsoft.OpenApi.Any;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add secrets (not tracked by github)
builder.Configuration.AddJsonFile($"secrets{(builder.Environment.IsProduction() ? "" : $".{builder.Environment.EnvironmentName}")}.json");

builder.Services.AddLogging().AddHttpLogging();

// Database
builder.Services.AddDbContext<ApplicationDbContext>();

// Controllers
builder.Services.AddControllers().AddJsonOptions(options => {
  options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
});

// Open API
builder.Services.AddOpenApi(options => {
  options.AddSchemaTransformer((schema, context, cancellationToken) => {
    if (context.JsonTypeInfo.Type.IsEnum) {
      schema.Type = "string";
      schema.Enum = context.JsonTypeInfo.Type.GetEnumNames().Select(name => new OpenApiString(name)).Cast<IOpenApiAny>().ToList();
    }
    return Task.CompletedTask;
  });
});

// Config
builder.Services.Configure<GoogleMapsConfig>(builder.Configuration.GetSection("GoogleMaps"));

builder.Services.AddTransient<IGeocodingService, GeocodingService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment()) {
  app.MapOpenApi();
  app.UseCors(builder => builder.AllowCredentials().AllowAnyHeader().AllowAnyMethod().SetIsOriginAllowed(origin => new Uri(origin).IsLoopback));
}

app.UseHttpsRedirection();

// Enable static file serving from wwwroot (for Flutter build)
app.UseDefaultFiles();
app.UseStaticFiles();

// Map API controllers
app.MapControllers();

app.Run();
