import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class WeatherProvider with ChangeNotifier {
  String _appId = 'be2acbcfe99b5fe0e4e59c3b35c3dd23';
  double _latitude,_longitude;
//  bool locationPermission = false;
//  double latitude;
//  double _longitude;
//
//  void getLocationPermission() async {
//    var _status = await Permission.camera.status;
//    if (_status.isGranted) {
//      locationPermission = true;
//    } else if (!_status.isGranted) {
//      await Permission.location.request();
//      getLocationPermission();
//    }
//    notifyListeners();
//  }
//
  Future<void> _getLocation() async {
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  String city;
  DateTime now = DateTime.now();
  String temp;
  String description;
  double windSpeed;
  int humidity;

  Future fetchingCurrentWeather(lat,lon)async{
    await _getLocation();
    String url = 'http://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=$_appId';
    final response = await http.get(url);
    try{
        Map decodedData = jsonDecode(response.body) as Map;
        city = decodedData['name'];
        temp = (decodedData['main']['temp'] - 273.15).toString().substring(0,2);
        description = decodedData['weather'][0]['description'];
        windSpeed = decodedData['wind']['speed'];
        humidity = decodedData['main']['humidity'];
        return {
          'city':city,
          'temp':temp,
          'description':description,
          'now':now,
          'windSpeed':windSpeed,
          'humidity':humidity,
        };
    }catch(error){
      print(error);
    }
  }
  Future<List> getForecast()async{
    await _getLocation();
    String url = 'https://samples.openweathermap.org/data/2.5/forecast/daily?lat=$_latitude&lon=$_longitude&cnt=7&appid=$_appId';
    final response =await http.get(url);
    try{
      List decodedData = jsonDecode(response.body)['list'] as List;
      print(jsonDecode(response.body)['city']['name']);
      return decodedData.sublist(1,7);
    }catch(e){
      print(e);
      return null;
    }
  }
}