﻿// <auto-generated />
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using backend.Db;

#nullable disable

namespace backend.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20250123033519_InitialMigration")]
    partial class InitialMigration
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "9.0.1");

            modelBuilder.Entity("backend.Db.PeakDataLocation", b =>
                {
                    b.Property<string>("Id")
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<string>("city")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("Locations");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeason", b =>
                {
                    b.Property<string>("Id")
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<string>("LocationId")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<int>("season")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("LocationId");

                    b.ToTable("LocationSeasons");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDay", b =>
                {
                    b.Property<string>("Id")
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<int>("Day")
                        .HasColumnType("INTEGER");

                    b.Property<string>("SeasonId")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.HasIndex("SeasonId");

                    b.ToTable("LocationSeasonDays");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDayEntry", b =>
                {
                    b.Property<string>("Id")
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<string>("DayId")
                        .HasColumnType("TEXT");

                    b.Property<int>("Type")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("DayId");

                    b.ToTable("LocationSeasonDayEntries");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDayEntryRange", b =>
                {
                    b.Property<string>("Id")
                        .HasMaxLength(100)
                        .HasColumnType("TEXT");

                    b.Property<int>("EndHour")
                        .HasColumnType("INTEGER");

                    b.Property<string>("EntryId")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<int>("StartHour")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("EntryId");

                    b.ToTable("LocationSeasonDayEntryRanges");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeason", b =>
                {
                    b.HasOne("backend.Db.PeakDataLocation", "Location")
                        .WithMany("seasons")
                        .HasForeignKey("LocationId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Location");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDay", b =>
                {
                    b.HasOne("backend.Db.PeakDataLocationSeason", "Season")
                        .WithMany("Days")
                        .HasForeignKey("SeasonId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Season");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDayEntry", b =>
                {
                    b.HasOne("backend.Db.PeakDataLocationSeasonDay", "Day")
                        .WithMany("Entries")
                        .HasForeignKey("DayId");

                    b.Navigation("Day");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDayEntryRange", b =>
                {
                    b.HasOne("backend.Db.PeakDataLocationSeasonDayEntry", "Entry")
                        .WithMany("Ranges")
                        .HasForeignKey("EntryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Entry");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocation", b =>
                {
                    b.Navigation("seasons");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeason", b =>
                {
                    b.Navigation("Days");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDay", b =>
                {
                    b.Navigation("Entries");
                });

            modelBuilder.Entity("backend.Db.PeakDataLocationSeasonDayEntry", b =>
                {
                    b.Navigation("Ranges");
                });
#pragma warning restore 612, 618
        }
    }
}
