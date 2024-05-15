import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/features/cities/presentation/cities_list_page.dart';
import 'package:travel_application/features/weather/models/weather_model.dart';
import 'package:travel_application/features/weather/services/weather_service.dart';
import 'package:travel_application/theme/colors_collection.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('0469d751c6831292929f7016cbfd7170');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = CityName.cityName;
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/weather/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fod':
        return 'assets/weather/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/weather/rain.json';
      case 'thunderstorm':
        return 'assets/weather/thunder.json';
      case 'clear':
        return 'assets/weather/sunny.json';
      case 'snow':
        return 'assets/weather/snow.json';
      default:
        return 'assets/weather/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).weather)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "loading city..",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: ColorsCollection.onSurface),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.round()}C',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorsCollection.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              _weather?.mainCondition ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorsCollection.outline),
            ),
          ],
        ),
      ),
    );
  }
}
