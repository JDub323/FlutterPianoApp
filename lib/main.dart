import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/all_pages_barrel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Piano Teacher App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade400),
          useMaterial3: true,
        ),
        home: const StartScreen(),
        routes: {
          '/startScreen': (context) => const StartScreen(),
          '/homeScreen': (context) => const HomeScreen(),
          '/shopScreen': (context) => const ShopScreen(),
          '/settingsScreen': (context) => const SettingsScreen(),
          '/customPracticeOptionSelectScreen': (context) =>
              const CustomPracticeOptionSelectScreen(),
              '/synthesia': (context) => const Synthesia(),
        });
  }
}
