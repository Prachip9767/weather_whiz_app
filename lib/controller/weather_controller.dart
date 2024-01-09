import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_whiz_app/data/cities_data.dart';
import 'package:weather_whiz_app/data/weather_forecast_data.dart';
import 'package:weather_whiz_app/network/api_service.dart';

import '../main.dart';

/// A class that manages weather-related functionality and state using the Provider package.

class WeatherController with ChangeNotifier {

  final List<WeatherForecastModal> _weatherData = [];   /// List to store weather forecast data.
  CitiesData? cities;
  final WeatherApiService _weatherAPI = WeatherApiService();/// Instance of the WeatherApiService for making API calls.

  bool isLoading = false; /// A flag to indicate whether data is currently being loaded.

  String? selectedValue; /// The currently selected value from the dropdown.

  List<WeatherForecastModal> get weatherData => _weatherData;   /// Getter for accessing the private weather data list.

  /// Asynchronous method to fetch weather data.
  Future<void> fetchWeather() async {
    isLoading = true;
    notifyListeners();
    try {
      final newWeatherData = await _weatherAPI.fetchWeather(selectedValue!);
      _weatherData.addAll(newWeatherData);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Asynchronous method to fetch city data.
  Future<void> fetchCity() async {
    try {
      cities = await _weatherAPI.fetchCities();
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
  /// Helper method to map weather icon codes to corresponding WeatherIcons.

  IconData getWeatherIconFromCode(String iconCode) {
    switch (iconCode) {
    /** Maps various weather icon codes to corresponding WeatherIcon data
    Returns appropriate WeatherIcon based on the provided icon code
    If no match is found, returns WeatherIcons.na
    (These icons are typically used to display weather conditions in the UI)
    Example: "01d" represents a sunny day, "09d" represents rain, etc.
    (WeatherIcons is a package that provides weather-related icons) **/
      case "01d":
        return WeatherIcons.day_sunny;
      case "01n":
        return WeatherIcons.night_clear;
      case "02d":
        return WeatherIcons.day_cloudy;
      case "02n":
        return WeatherIcons.night_cloudy;
      case "03d":
        return WeatherIcons.cloudy_gusts;
      case "03n":
        return WeatherIcons.cloud;
      case "04d":
      case "04n":
        return WeatherIcons.cloudy;
      case "09d":
      case "09n":
        return WeatherIcons.rain;
      case "10d":
      case "10n":
        return WeatherIcons.showers;
      case "11d":
      case "11n":
        return WeatherIcons.thunderstorm;
      case "13d":
      case "13n":
        return WeatherIcons.snow;
      case "50d":
      case "50n":
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na;
    }
  }

  /// Helper method to convert temperature from Kelvin to Celsius.
  double temperatureToCelsius(double tempData) {
    double temp = tempData - 273.15;
    return temp;
  }

  /// Helper method to convert Unix timestamp to IST formatted time.
  String convertUnixTimestampToIST(int timestamp) {
    final int millisecondsSinceEpoch = timestamp * 1000;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final DateTime istDateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formattedIST = formatter.format(istDateTime);
    return formattedIST;
  }
}

