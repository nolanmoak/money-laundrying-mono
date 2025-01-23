using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class IndexesAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_LocationSeasonDayEntries_LocationSeasonDays_DayId",
                table: "LocationSeasonDayEntries");

            migrationBuilder.DropIndex(
                name: "IX_LocationSeasons_LocationId",
                table: "LocationSeasons");

            migrationBuilder.DropIndex(
                name: "IX_LocationSeasonDays_SeasonId",
                table: "LocationSeasonDays");

            migrationBuilder.DropIndex(
                name: "IX_LocationSeasonDayEntries_DayId",
                table: "LocationSeasonDayEntries");

            migrationBuilder.RenameColumn(
                name: "season",
                table: "LocationSeasons",
                newName: "Season");

            migrationBuilder.RenameColumn(
                name: "city",
                table: "Locations",
                newName: "City");

            migrationBuilder.AlterColumn<string>(
                name: "DayId",
                table: "LocationSeasonDayEntries",
                type: "TEXT",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasons_LocationId_Season",
                table: "LocationSeasons",
                columns: new[] { "LocationId", "Season" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDays_SeasonId_Day",
                table: "LocationSeasonDays",
                columns: new[] { "SeasonId", "Day" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDayEntries_DayId_Type",
                table: "LocationSeasonDayEntries",
                columns: new[] { "DayId", "Type" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Locations_City",
                table: "Locations",
                column: "City",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_LocationSeasonDayEntries_LocationSeasonDays_DayId",
                table: "LocationSeasonDayEntries",
                column: "DayId",
                principalTable: "LocationSeasonDays",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_LocationSeasonDayEntries_LocationSeasonDays_DayId",
                table: "LocationSeasonDayEntries");

            migrationBuilder.DropIndex(
                name: "IX_LocationSeasons_LocationId_Season",
                table: "LocationSeasons");

            migrationBuilder.DropIndex(
                name: "IX_LocationSeasonDays_SeasonId_Day",
                table: "LocationSeasonDays");

            migrationBuilder.DropIndex(
                name: "IX_LocationSeasonDayEntries_DayId_Type",
                table: "LocationSeasonDayEntries");

            migrationBuilder.DropIndex(
                name: "IX_Locations_City",
                table: "Locations");

            migrationBuilder.RenameColumn(
                name: "Season",
                table: "LocationSeasons",
                newName: "season");

            migrationBuilder.RenameColumn(
                name: "City",
                table: "Locations",
                newName: "city");

            migrationBuilder.AlterColumn<string>(
                name: "DayId",
                table: "LocationSeasonDayEntries",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldMaxLength: 100);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasons_LocationId",
                table: "LocationSeasons",
                column: "LocationId");

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDays_SeasonId",
                table: "LocationSeasonDays",
                column: "SeasonId");

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDayEntries_DayId",
                table: "LocationSeasonDayEntries",
                column: "DayId");

            migrationBuilder.AddForeignKey(
                name: "FK_LocationSeasonDayEntries_LocationSeasonDays_DayId",
                table: "LocationSeasonDayEntries",
                column: "DayId",
                principalTable: "LocationSeasonDays",
                principalColumn: "Id");
        }
    }
}
