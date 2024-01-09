import 'package:flutter/material.dart';
import 'package:weather_whiz_app/data/weather_forecast_data.dart';

/// Widget to display weather information in a card format.
class WeatherCard extends StatelessWidget {
  final WeatherForecastModal weatherData;
  final IconData Function(String) getWeatherIconFromCode;
  final double Function(double) temperatureToCelsius;

  const WeatherCard({
    required this.weatherData,
    required this.getWeatherIconFromCode,
    required this.temperatureToCelsius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weatherData.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_formatTemperature(weatherData.main.temp)}°C',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Icon(
                getWeatherIconFromCode(weatherData.weather[0].icon),
                size: 50,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            weatherData.weather[0].description,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Humidity', '${weatherData.main.humidity}%'),
          const SizedBox(height: 8),
          _buildInfoRow('Low', '${_formatTemperature(weatherData.main.tempMin)}°C'),
          const SizedBox(height: 8),
          _buildInfoRow('High', '${_formatTemperature(weatherData.main.tempMax)}°C'),
        ],
      ),
    );
  }

  /// Format temperature to a string with two decimal places.

  String _formatTemperature(double temperature) {
    return temperatureToCelsius(temperature).toStringAsFixed(2);
  }

  ///Build a row for displaying additional information (label and value).

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
