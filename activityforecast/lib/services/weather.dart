import 'package:activityforecast/services/location.dart';
import 'package:activityforecast/services/network.dart';

const apiKey = '82e8ee4abaa379a0287b7798ae32c0ed'; //'fc6a05cad5b2a95ef99622d54d0f2828';
const openWeatherMapLocURL = 'https://api.openweathermap.org/data/2.5/weather';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/onecall';


// &exclude={current,minutely,hourly}

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {

    // get lat/long from city name
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapLocURL?q=$cityName&appid=$apiKey&units=metric');

    var locData = await networkHelper.getData();

    if (locData != null) {
      double lon = locData['coord']['lon'];
      double lat = locData['coord']['lat'];

      // get weather
      NetworkHelper networkHelper2 = NetworkHelper(
          '$openWeatherMapURL?lat=${lat}&lon=${lon}&exclude=current,minutely,hourly&appid=$apiKey&units=metric');

      var weatherData = await networkHelper2.getData();

      return weatherData;
    } else {
      return null;
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&exclude={current,minutely,hourly}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeather(Location location) async {

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&exclude={current,minutely,hourly}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'thunderstorm';
    } else if (condition < 400) {
      return 'drizzle';
    } else if (condition < 600) {
      return 'rainy';
    } else if (condition < 700) {
      return 'snowy';
    } else if (condition < 800) {
      return 'fog';
    } else if (condition == 800) {
      return 'sunny';
    } else {
      return 'cloudy';
    }
  }
}
