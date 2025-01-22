using Microsoft.AspNetCore.OpenApi;
using Microsoft.OpenApi.Any;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddControllers().AddJsonOptions(options => {
  options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
});
builder.Services.AddOpenApi(options => {
  options.AddSchemaTransformer((schema, context, cancellationToken) => {
    if (context.JsonTypeInfo.Type.IsEnum) {
      schema.Type = "string";
      schema.Enum = context.JsonTypeInfo.Type.GetEnumNames().Select(name => new OpenApiString(name)).Cast<IOpenApiAny>().ToList();
    }
    return Task.CompletedTask;
  });
});

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
