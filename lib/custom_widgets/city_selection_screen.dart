import 'package:flutter/material.dart';

/// Widget for selecting a city from a dropdown list.

class CitySelectionScreen extends StatelessWidget {
  final List<String> cities;
  final String? selectedValue;
  final Function(String?) onValueChanged;

  const CitySelectionScreen({
    Key? key,
    required this.cities,
    this.selectedValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          const Text(
            'Select City:',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(width: 40),
          _buildDropdown(context),
        ],
      ),
    );
  }
  Widget _buildDropdown(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: DropdownButton<String>(
          hint: Text(cities.isEmpty ? 'No Data Available' : 'Select City'),
          value: selectedValue,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onValueChanged(newValue); /// Inform the WeatherController about the new selection
              Navigator.of(context).pop(); /// Pop immediately after selection
            }
          },
          items: cities.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

}
