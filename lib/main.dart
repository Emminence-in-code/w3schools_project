import 'package:flutter/material.dart';
import 'package:w3schools_project/widgets/custom_introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String initialUrl = pref.getString('initialUrl') == null
      ? 'https://www.w3schools.com'
      : pref.getString('initialUrl')!;
  runApp(MyApp(initialUrl: initialUrl, pref: pref));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialUrl, required this.pref});
  final String initialUrl;
  final SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W3 Schools',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 7, 100, 10)),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: CustomIntroduction(
          pref: pref,
          initialUrl: initialUrl,
        ),
      ),
    );
  }
}
