using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class LocationCountries : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Locations_City",
                table: "Locations");

            migrationBuilder.AddColumn<string>(
                name: "Country",
                table: "Locations",
                type: "TEXT",
                maxLength: 255,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "CountryCode",
                table: "Locations",
                type: "TEXT",
                maxLength: 255,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "State",
                table: "Locations",
                type: "TEXT",
                maxLength: 255,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "StateCode",
                table: "Locations",
                type: "TEXT",
                maxLength: 255,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_Locations_City_CountryCode",
                table: "Locations",
                columns: new[] { "City", "CountryCode" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Locations_City_CountryCode",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "Country",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "CountryCode",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "State",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "StateCode",
                table: "Locations");

            migrationBuilder.CreateIndex(
                name: "IX_Locations_City",
                table: "Locations",
                column: "City",
                unique: true);
        }
    }
}
