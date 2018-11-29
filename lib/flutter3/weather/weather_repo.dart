import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'weather_model.dart';
import 'weater.dart';

const String API_KEY = '81ec6c6254a4da3cc1b8266921e98ad4';

class WeatherRepo {
  WeatherRepo({this.client});

  final http.Client client;
  int cnt = 50;

  Location _location = Location();

  void addCities(int count) {
    cnt = count;
  }

  Future<List<WeatherModel>> updateWeather(Map<String,dynamic> location) async {
    String url;
    if (location != null) {
      double lat = location['latitude'];
      double lon = location['longitude'];
      url = 'http://api.openweathermap.org/data/2.5/find?lat=$lat&lon=$lon&cnt=$cnt&appid=$API_KEY';
    } else {
      url = 'http://api.openweathermap.org/data/2.5/find?lat=43&lon=-79&cnt=10&appid=$API_KEY';
    }
    final response = await client.get(url);
    List<WeatherModel> req = BaseResponse.fromJson(json.decode(response.body))
        .cities
        .map((city) => WeatherModel.fromResponse(city))
        .toList();
    return req;
  }

  Future<Map<String, double>> updateLocation() async {
    return await _location.getLocation();
  }

  Future<bool> getGps() async {
    return await _location.hasPermission();
  }
}
