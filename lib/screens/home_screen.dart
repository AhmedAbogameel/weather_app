import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/helpers/screen_helper.dart';
import 'package:weather_app/widgets/small_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool locationPermission = false;
  void getMyLocation()async{
    if(await Permission.location.isGranted){
      setState(() {
        locationPermission = true;
      });
    }
    if(locationPermission){
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('long : ${position.longitude}');
      print('lati : ${position.latitude}');
    }else{
      await Permission.location.request();
    }
  }

  @override
  void initState() {
    getMyLocation();
    Timer.periodic(Duration(seconds: 3), (timer){
      getMyLocation();
      if(locationPermission){timer.cancel();}
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(25),
        child: locationPermission ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  'New York',
                  // ignore: deprecated_member_use
                  style: textTheme.title,
                ),
                subtitle: Text(
                  'Wed 4 Dec 2019',
                  // ignore: deprecated_member_use
                  style: textTheme.subtitle,
                ),
                onTap: (){
                  Navigator.pushNamed(context, 'fake');
                },
              ),
            ),
            Center(
              child: FittedBox(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Today',
                      // ignore: deprecated_member_use
                      style: textTheme.title.copyWith(fontSize: 40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          WeatherIcons.wiDaySunny,
                          size: ScreenHelper.screenFont(context, 70),
                          color: theme.primaryColor,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '38°',
                          // ignore: deprecated_member_use
                          style: textTheme.title.copyWith(fontSize: 100),
                        ),
                      ],
                    ),
                    Text(
                      'Partly Cloudy',
                      // ignore: deprecated_member_use
                      style: textTheme.subtitle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        '11km/h',
                        // ignore: deprecated_member_use
                        style: textTheme.title,
                      ),
                      subtitle: Text(
                        'Wind',
                        // ignore: deprecated_member_use
                        style: textTheme.subtitle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        '78%',
                        // ignore: deprecated_member_use
                        style: textTheme.title,
                      ),
                      subtitle: Text(
                        'Humidity',
                        // ignore: deprecated_member_use
                        style: textTheme.subtitle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        '38°',
                        // ignore: deprecated_member_use
                        style: textTheme.title,
                      ),
                      subtitle: Text(
                        'Feels Like',
                        // ignore: deprecated_member_use
                        style: textTheme.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _fakeData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,index)=> SmallCard(
                  day: _fakeData[index][0],
                  temp: _fakeData[index][2],
                  weatherIcon: _fakeData[index][1],
                ),
              ),
            ),
          ],
        ) : Center(
          child: Text('Please Give me GPS PERMISSION',style: textTheme.title.copyWith(fontSize: 70),),
        )
      ),
    );
  }

  final List _fakeData = [
    [
      'THU',
      WeatherIcons.wiWindy,
      45,
    ],
    [
      'FRI',
      WeatherIcons.wiSunset,
      25,
    ],
    [
      'SAT',
      WeatherIcons.wiStars,
      13,
    ],
    [
      'SUN',
      WeatherIcons.wiTornado,
      30,
    ],
    [
      'TUE',
      WeatherIcons.wiTsunami,
      18,
    ]
  ];
}