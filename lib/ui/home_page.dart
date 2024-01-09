import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_whiz_app/controller/weather_controller.dart';
import 'package:weather_whiz_app/custom_widgets/city_selection_screen.dart';
import 'package:weather_whiz_app/theme/app_color.dart';
import '../custom_widgets/weather_card_item.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late WeatherController weatherController;

  @override
  void initState() {
    super.initState();
    weatherController = Provider.of<WeatherController>(context, listen: false);
    weatherController.fetchCity();
    weatherController.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Weather Whiz'),
        elevation: 4,
        actions: [
          OutlinedButton(
            child: const Text(
              'Add Location',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              weatherController.isLoading = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelectionScreen(
                    cities: weatherController.cities?.cities ?? [],
                    selectedValue: weatherController.selectedValue,
                    onValueChanged: (String? newValue) {
                      weatherController.selectedValue = newValue;
                      weatherController.fetchWeather();
                    },
                  ),
                ),
              ); // Reset the loading state when the screen pops
            },
          )
        ],
      ),
      body: Consumer<WeatherController>(
        builder: (context, weatherProvider, child) {
          if (weatherController.isLoading==true) {
            print('show loader');
            return Center(child: CircularProgressIndicator()); // Show loader
          } else {
            print(weatherController.isLoading);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Expanded(
                    child: weatherController.weatherData.isNotEmpty
                        ? ListView.separated(
                      separatorBuilder: (context, index) => const Divider(height: 16),
                      itemCount: weatherController.weatherData.length,
                      itemBuilder: (context, index) {
                        final weather = weatherController.weatherData[index];
                        return Container(
                          child: WeatherCard(
                            getWeatherIconFromCode: weatherController.getWeatherIconFromCode,
                            temperatureToCelsius: weatherController.temperatureToCelsius,
                            weatherData: weather,
                          ),
                        );
                      },
                    )
                        : const Center(
                      child: Text(
                        'No Location Added',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

