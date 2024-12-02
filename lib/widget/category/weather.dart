import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // Dummy weather data
  final Map<String, dynamic> currentWeather = {
    "temperature": "28°C",
    "condition": "Sunny",
    "location": "Indore",
    "icon": Icons.wb_sunny,
  };

  final List<Map<String, String>> weeklyForecast = [
    {"day": "Mon", "temp": "30°C", "condition": "Sunny"},
    {"day": "Tue", "temp": "29°C", "condition": "Cloudy"},
    {"day": "Wed", "temp": "28°C", "condition": "Rainy"},
    {"day": "Thu", "temp": "31°C", "condition": "Sunny"},
    {"day": "Fri", "temp": "27°C", "condition": "Rainy"},
    {"day": "Sat", "temp": "32°C", "condition": "Cloudy"},
    {"day": "Sun", "temp": "33°C", "condition": "Sunny"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weather Section
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      currentWeather['icon'],
                      size: 50,
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentWeather['location'],
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: StyleConstants.darkGreen,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentWeather['condition'],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          currentWeather['temperature'],
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Weekly Forecast Section
            Text(
              "7-Day Forecast",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: weeklyForecast.length,
                itemBuilder: (context, index) {
                  final dayForecast = weeklyForecast[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dayForecast['day']!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            dayForecast['temp']!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            dayForecast['condition']!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
