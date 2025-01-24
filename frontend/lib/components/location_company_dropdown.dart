import 'package:flutter/material.dart';
import 'package:money_laundrying_frontend/generated/spec.swagger.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LocationCompanyDropdown extends StatefulWidget {
  const LocationCompanyDropdown({
    super.key,
    required this.locationsAndCompanies,
    required this.selected,
    required this.currentLocation,
    required this.onSelected,
  });

  final Future<LocationAndCompanyModel> locationsAndCompanies;
  final Future<Location?> currentLocation;
  final LocationAndCompany? selected;
  final void Function(LocationAndCompany?) onSelected;

  @override
  State<LocationCompanyDropdown> createState() =>
      _LocationCompanyDropdownState();
}

class _LocationCompanyDropdownState extends State<LocationCompanyDropdown> {
  final dropDownKey = GlobalKey<DropdownSearchState>();
  Location? currentLocationResolved;

  void updateCurrentLocation() async {
    final currentResolved = await widget.currentLocation;
    setState(() {
      currentLocationResolved = currentResolved;
    });
  }

  @override
  void initState() {
    super.initState();
    updateCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      children: [
        if (widget.selected != null) const Icon(Icons.location_on, size: 40),
        Expanded(
          child: DropdownSearch<LocationAndCompany?>(
            key: dropDownKey,
            selectedItem: widget.selected,
            onChanged: (locationAndCompany) =>
                widget.onSelected(locationAndCompany),
            items: (filter, infiniteScrollProps) async {
              return (await widget.locationsAndCompanies).locationsAndCompanies;
            },
            decoratorProps: const DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: 'Electricity Company',
                border: UnderlineInputBorder(),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(autofocus: true),
              fit: FlexFit.loose,
              constraints: const BoxConstraints(),
              itemBuilder:
                  (context, locationAndCompany, isDisabled, isSelected) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 2,
                    children: [
                      if (locationAndCompany != null &&
                          currentLocationResolved != null &&
                          locationAndCompany.location.id ==
                              currentLocationResolved!.id)
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                      Expanded(
                        child: Text(
                          locationAndCompany != null
                              ? '${locationAndCompany.company.name} (${locationAndCompany.location.city}, ${locationAndCompany.location.stateCode}, ${locationAndCompany.location.countryCode}'
                              : 'Set Location...',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      if (isSelected) const Icon(Icons.check, size: 20),
                    ],
                  ),
                );
              },
            ),
            filterFn: (locationAndCompany, filter) {
              filter = filter.toLowerCase();
              return locationAndCompany != null &&
                  (locationAndCompany.company.name
                          .toLowerCase()
                          .contains(filter) ||
                      locationAndCompany.location.city
                          .toLowerCase()
                          .contains(filter) ||
                      locationAndCompany.location.state
                          .toLowerCase()
                          .contains(filter) ||
                      locationAndCompany.location.country
                          .toLowerCase()
                          .contains(filter));
            },
            itemAsString: (locationAndCompany) => locationAndCompany != null
                ? '${locationAndCompany.company.name} (${locationAndCompany.location.city}, ${locationAndCompany.location.stateCode}, ${locationAndCompany.location.countryCode})'
                : 'Set Location...',
            compareFn: (locationAndCompany1, locationAndCompany2) =>
                locationAndCompany1 == null && locationAndCompany2 == null ||
                (locationAndCompany1 != null &&
                    locationAndCompany2 != null &&
                    locationAndCompany1.company.id ==
                        locationAndCompany2.company.id),
          ),
        ),
      ],
    );
  }
}
