import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_whiz_app/controller/weather_controller.dart';
import 'package:weather_whiz_app/ui/home_page.dart';
import 'package:weather_whiz_app/theme/app_color.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherController()),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast App',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.dark, // Change theme mode as needed
      home: const WeatherHomePage(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      cardTheme: const CardTheme(color: AppColors.yellowLight),
      appBarTheme: const AppBarTheme(
        color: AppColors.yellowDark2,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: 24,
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      cardTheme: CardTheme(
        color: AppColors.purpleAccentColor.withOpacity(0.2),
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.purpleAccentColor.withOpacity(0.6),
        titleTextStyle: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 24,
        ),
      ),
    );
  }
}
