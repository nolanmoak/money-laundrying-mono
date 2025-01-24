import 'package:flutter/material.dart';
import 'package:money_laundrying_frontend/components/current_time.dart';
import 'package:money_laundrying_frontend/components/dial.dart';
import 'package:money_laundrying_frontend/components/electricity_company_link.dart';
import 'package:money_laundrying_frontend/components/location_company_dropdown.dart';
import 'package:money_laundrying_frontend/generated/spec.swagger.dart';
import 'package:money_laundrying_frontend/services/location_service.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key, required this.title, required this.apiUrl});

  final String title;
  final String apiUrl;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  late Spec apiSpec;
  late Future<Location?> currentLocation;
  Future<DataModel?>? currentPeakData;
  late Future<LocationAndCompanyModel> locationsAndCompaniesFlat;
  LocationAndCompany? selectedLocationAndCompany;

  @override
  void initState() {
    super.initState();
    apiSpec = Spec.create(baseUrl: Uri.parse(widget.apiUrl));
    locationsAndCompaniesFlat = getLocationsAndCompaniesFlat();
    currentLocation = getCurrentLocation();
  }

  Future<Location?> getCurrentLocation() async {
    final position = await determinePosition();
    final response = await apiSpec.apiLocationCurrentGet(
        latitude: position?.latitude, longitude: position?.longitude);
    final loc = response.body;

    if (loc != null && selectedLocationAndCompany == null) {
      locationsAndCompaniesFlat.then((allLocationsAndCompanies) {
        selectLocationAndCompany(allLocationsAndCompanies.locationsAndCompanies
            .where((locationAndCompany) =>
                locationAndCompany.location.id == loc.id)
            .first);
      });
    }

    return loc;
  }

  Future<DataModel> getPeakData(String companyId) async {
    final response = await apiSpec.apiDataGet(
      companyId: companyId,
    );
    final responseBody = response.body;
    if (responseBody == null) {
      throw Exception('Unable to load data');
    }
    return responseBody;
  }

  Future<LocationAndCompanyModel> getLocationsAndCompaniesFlat() async {
    final response = await apiSpec.apiLocationCompaniesFlatGet();
    final responseBody = response.body;
    if (responseBody == null) {
      throw Exception('Unable to load locations');
    }
    return responseBody;
  }

  void reloadData() {
    setState(() {
      locationsAndCompaniesFlat = getLocationsAndCompaniesFlat();
      currentLocation = getCurrentLocation();
    });
  }

  void selectLocationAndCompany(LocationAndCompany? locationAndCompany) {
    if (locationAndCompany?.company.id ==
        selectedLocationAndCompany?.company.id) {
      return;
    }
    setState(() {
      selectedLocationAndCompany = locationAndCompany;
      if (locationAndCompany != null) {
        currentPeakData = getPeakData(locationAndCompany.company.id);
      } else {
        currentPeakData = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        toolbarHeight: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: LocationCompanyDropdown(
                locationsAndCompanies: locationsAndCompaniesFlat,
                currentLocation: currentLocation,
                selected: selectedLocationAndCompany,
                onSelected: selectLocationAndCompany,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CurrentTime(),
                ElectricityCompanyLink(
                    selectedLocationAndCompany: selectedLocationAndCompany),
              ],
            ),
            Expanded(
              child: Dial(
                data: currentPeakData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
