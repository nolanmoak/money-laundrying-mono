using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class MultipleElectricityCompanies : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Locations_ElectricityCompanies_ElectricityCompanyId",
                table: "Locations");

            migrationBuilder.DropTable(
                name: "LocationSeasonDayEntryRanges");

            migrationBuilder.DropTable(
                name: "LocationSeasonDayEntries");

            migrationBuilder.DropTable(
                name: "LocationSeasonDays");

            migrationBuilder.DropTable(
                name: "LocationSeasons");

            migrationBuilder.DropIndex(
                name: "IX_Locations_ElectricityCompanyId",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "ElectricityCompanyId",
                table: "Locations");

            migrationBuilder.AddColumn<string>(
                name: "LocationId",
                table: "ElectricityCompanies",
                type: "TEXT",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "ElectricityCompanySeasons",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Season = table.Column<int>(type: "INTEGER", nullable: false),
                    CompanyId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityCompanySeasons", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ElectricityCompanySeasons_ElectricityCompanies_CompanyId",
                        column: x => x.CompanyId,
                        principalTable: "ElectricityCompanies",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ElectricityCompanySeasonDays",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Day = table.Column<int>(type: "INTEGER", nullable: false),
                    SeasonId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityCompanySeasonDays", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ElectricityCompanySeasonDays_ElectricityCompanySeasons_SeasonId",
                        column: x => x.SeasonId,
                        principalTable: "ElectricityCompanySeasons",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ElectricityCompanySeasonDayEntries",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Type = table.Column<int>(type: "INTEGER", nullable: false),
                    DayId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityCompanySeasonDayEntries", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ElectricityCompanySeasonDayEntries_ElectricityCompanySeasonDays_DayId",
                        column: x => x.DayId,
                        principalTable: "ElectricityCompanySeasonDays",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ElectricityCompanySeasonDayEntryRanges",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    StartHour = table.Column<int>(type: "INTEGER", nullable: false),
                    EndHour = table.Column<int>(type: "INTEGER", nullable: false),
                    EntryId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityCompanySeasonDayEntryRanges", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ElectricityCompanySeasonDayEntryRanges_ElectricityCompanySeasonDayEntries_EntryId",
                        column: x => x.EntryId,
                        principalTable: "ElectricityCompanySeasonDayEntries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Locations_City_StateCode_CountryCode",
                table: "Locations",
                columns: new[] { "City", "StateCode", "CountryCode" });

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityCompanies_LocationId",
                table: "ElectricityCompanies",
                column: "LocationId");

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityCompanySeasonDayEntries_DayId_Type",
                table: "ElectricityCompanySeasonDayEntries",
                columns: new[] { "DayId", "Type" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityCompanySeasonDayEntryRanges_EntryId",
                table: "ElectricityCompanySeasonDayEntryRanges",
                column: "EntryId");

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityCompanySeasonDays_SeasonId_Day",
                table: "ElectricityCompanySeasonDays",
                columns: new[] { "SeasonId", "Day" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityCompanySeasons_CompanyId_Season",
                table: "ElectricityCompanySeasons",
                columns: new[] { "CompanyId", "Season" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ElectricityCompanies_Locations_LocationId",
                table: "ElectricityCompanies",
                column: "LocationId",
                principalTable: "Locations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ElectricityCompanies_Locations_LocationId",
                table: "ElectricityCompanies");

            migrationBuilder.DropTable(
                name: "ElectricityCompanySeasonDayEntryRanges");

            migrationBuilder.DropTable(
                name: "ElectricityCompanySeasonDayEntries");

            migrationBuilder.DropTable(
                name: "ElectricityCompanySeasonDays");

            migrationBuilder.DropTable(
                name: "ElectricityCompanySeasons");

            migrationBuilder.DropIndex(
                name: "IX_Locations_City_StateCode_CountryCode",
                table: "Locations");

            migrationBuilder.DropIndex(
                name: "IX_ElectricityCompanies_LocationId",
                table: "ElectricityCompanies");

            migrationBuilder.DropColumn(
                name: "LocationId",
                table: "ElectricityCompanies");

            migrationBuilder.AddColumn<string>(
                name: "ElectricityCompanyId",
                table: "Locations",
                type: "TEXT",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "LocationSeasons",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    LocationId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Season = table.Column<int>(type: "INTEGER", nullable: false)
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
                    SeasonId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Day = table.Column<int>(type: "INTEGER", nullable: false)
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
                    DayId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Type = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LocationSeasonDayEntries", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LocationSeasonDayEntries_LocationSeasonDays_DayId",
                        column: x => x.DayId,
                        principalTable: "LocationSeasonDays",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "LocationSeasonDayEntryRanges",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    EntryId = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    EndHour = table.Column<int>(type: "INTEGER", nullable: false),
                    StartHour = table.Column<int>(type: "INTEGER", nullable: false)
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
                name: "IX_Locations_ElectricityCompanyId",
                table: "Locations",
                column: "ElectricityCompanyId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDayEntries_DayId_Type",
                table: "LocationSeasonDayEntries",
                columns: new[] { "DayId", "Type" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDayEntryRanges_EntryId",
                table: "LocationSeasonDayEntryRanges",
                column: "EntryId");

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasonDays_SeasonId_Day",
                table: "LocationSeasonDays",
                columns: new[] { "SeasonId", "Day" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_LocationSeasons_LocationId_Season",
                table: "LocationSeasons",
                columns: new[] { "LocationId", "Season" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Locations_ElectricityCompanies_ElectricityCompanyId",
                table: "Locations",
                column: "ElectricityCompanyId",
                principalTable: "ElectricityCompanies",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
