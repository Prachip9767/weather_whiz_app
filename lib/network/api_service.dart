import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_whiz_app/data/cities_data.dart';
import 'package:weather_whiz_app/data/weather_forecast_data.dart';

/// A service class for making API calls related to weather information.

class WeatherApiService {

  final String apiKey = '2091953ce6ab36724ab3ff0c928fb2d0'; /// API key for accessing the OpenWeatherMap API.

  /// Fetch weather data for a specific city using the OpenWeatherMap API.
  Future<List<WeatherForecastModal>> fetchWeather(String city) async {
    final List<WeatherForecastModal> weatherData = [];

    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiKey'));

      /// Check if the request was successful (status code 200).
    if (response.statusCode == 200) {

      /// Parse the JSON response and convert it into a WeatherForecastModal object.
      weatherData.add(
            WeatherForecastModal.fromJson(json.decode(response.body)));
      } else {
        throw Exception('Failed to load weather data for $city');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }

    return weatherData;
  }

  Future<CitiesData> fetchCities() async {
    try {

      /// Make a GET request to a mock API endpoint that provides cities data.
    final response = await http.get(Uri.parse(
          'https://a944ede2-133d-45fa-82e1-0fb951492eda.mock.pstmn.io/cities'));

    /// Check if the request was successful (status code 200).
    if (response.statusCode == 200) {

      /// Parse the JSON response and convert it into a CitiesData object.

      final Map<String, dynamic> data = jsonDecode(response.body);
        return CitiesData.fromJson(data);
      } else {
        throw Exception('Failed to load cities data');
      }
    } catch (e) {
      throw Exception('Failed to fetch cities data: $e');
    }
  }
}
