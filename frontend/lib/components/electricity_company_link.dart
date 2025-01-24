import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_laundrying_frontend/components/empty.dart';
import 'package:money_laundrying_frontend/generated/spec.swagger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:universal_html/html.dart' as html;

class ElectricityCompanyLink extends StatelessWidget {
  const ElectricityCompanyLink(
      {super.key, required this.selectedLocationAndCompany});

  final LocationAndCompany? selectedLocationAndCompany;

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      return Future.error('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return selectedLocationAndCompany != null
        ? TextButton(
            onPressed: () => _openUrl(selectedLocationAndCompany!.company.url),
            child: Row(
              spacing: 2,
              children: [
                const Icon(Icons.open_in_new, size: 40),
                Text(
                  selectedLocationAndCompany!.company.name,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          )
        : const Empty();
  }
}
