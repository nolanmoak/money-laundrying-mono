using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class ElectricityCompanies : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ElectricityCompanyId",
                table: "Locations",
                type: "TEXT",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "ElectricityCompanies",
                columns: table => new
                {
                    Id = table.Column<string>(type: "TEXT", maxLength: 100, nullable: false),
                    Name = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false),
                    Url = table.Column<string>(type: "TEXT", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityCompanies", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Locations_ElectricityCompanyId",
                table: "Locations",
                column: "ElectricityCompanyId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Locations_ElectricityCompanies_ElectricityCompanyId",
                table: "Locations",
                column: "ElectricityCompanyId",
                principalTable: "ElectricityCompanies",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Locations_ElectricityCompanies_ElectricityCompanyId",
                table: "Locations");

            migrationBuilder.DropTable(
                name: "ElectricityCompanies");

            migrationBuilder.DropIndex(
                name: "IX_Locations_ElectricityCompanyId",
                table: "Locations");

            migrationBuilder.DropColumn(
                name: "ElectricityCompanyId",
                table: "Locations");
        }
    }
}
