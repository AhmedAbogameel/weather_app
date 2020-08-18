import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier{
  String _appId = 'be2acbcfe99b5fe0e4e59c3b35c3dd23';

  Future fetchingWeather(lat,lon)async{
    String url = 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_appId';
    final response = await http.get(url);
    print(response.statusCode);
  }

}