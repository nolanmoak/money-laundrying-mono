import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_laundrying_frontend/routes/home_route.dart';

late final String apiUrl;

void main() async {
  if (kIsWeb && kReleaseMode) {
    apiUrl = Uri.base.toString();
  } else {
    await dotenv.load();
    apiUrl = dotenv.env['API_URL'] ?? '';
  }

  if (apiUrl.isEmpty) {
    throw Exception('Unable to load API URL');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Laundrying',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: HomeRoute(
        title: 'Money Laundrying',
        apiUrl: apiUrl,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
