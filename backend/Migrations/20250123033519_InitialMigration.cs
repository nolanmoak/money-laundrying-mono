using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class InitialMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Locations",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    city = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Locations", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "LocationSeasons",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    season = table.Column<int>(type: "INTEGER", nullable: false),
                    LocationId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LocationSeasons", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LocationSeasons_Locations_LocationId",
                        column: x => x.LocationId,
                        principalTable: "Locations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LocationSeasonDays",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Day = table.Column<int>(type: "INTEGER", nullable: false),
                    SeasonId = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LocationSeasonDays", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LocationSeasonDays_LocationSeasons_SeasonId",
                        column: x => x.SeasonId,
                        principalTable: "LocationSeasons",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LocationSeasonDayEntries",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Type = table.Column<int>(type: "INTEGER", nullable: false),
                    DayId = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LocationSeasonDayEntries", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LocationSeasonDayEntries_LocationSeasonDays_DayId",
                        column: x => x.DayId,
                        principalTable: "LocationSeasonDays",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "LocationSeasonDayEntryRanges",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    StartHour = table.Column<int>(type: "INTEGER", nullable: false),
                    EndHour = table.Column<int>(type: "INTEGER", nullable: false),
                    EntryId = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LocationSeasonDayEntryRanges", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LocationSeasonDayEntryRanges_LocationSeasonDayEntries_EntryId",
                        column: x => x.EntryId,
                        principalTable: "LocationSeasonDayEntries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDayEntries_DayId",
                table: "LocationSeasonDayEntries",
                column: "DayId");

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDayEntryRanges_EntryId",
                table: "LocationSeasonDayEntryRanges",
                column: "EntryId");

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDays_SeasonId",
                table: "LocationSeasonDays",
                column: "SeasonId");

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasons_LocationId",
                table: "LocationSeasons",
                column: "LocationId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LocationSeasonDayEntryRanges");

            migrationBuilder.DropTable(
                name: "LocationSeasonDayEntries");

            migrationBuilder.DropTable(
                name: "LocationSeasonDays");

            migrationBuilder.DropTable(
                name: "LocationSeasons");

            migrationBuilder.DropTable(
                name: "Locations");
        }
    }
}
