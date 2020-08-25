import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/helpers/screen_helper.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/small_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool locationPermission = true;
  double lat;
  double lon;
  Future fetchCurrent , fetchForecast;
  void getMyLocation() async {
    if(await Permission.location.isGranted){
      setState(() {
        locationPermission = true;
      });
    }
    if (locationPermission) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lon = position.longitude;
      lat = position.latitude;
    } else {
      await Permission.location.request();
    }
  }

  @override
  void initState() {
    getMyLocation();
    Future.delayed(Duration.zero).then((_) {fetchCurrent =
        Provider.of<WeatherProvider>(context,listen: false).fetchingCurrentWeather(lat, lon);
      fetchForecast = Provider.of<WeatherProvider>(context,listen: false).getForecast();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.all(25),
          child: locationPermission
              ? FutureBuilder(
                  future: fetchCurrent,
                  builder: (context, snapshot) => snapshot.hasData ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            snapshot.data['city'],
                            // ignore: deprecated_member_use
                            style: textTheme.title,
                          ),
                          subtitle: Text(
                            '${snapshot.data['now']}',
                            // ignore: deprecated_member_use
                            style: textTheme.subtitle,
                          ),
                          onTap: () {},
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
                                    '${snapshot.data['temp']}°',
                                    // ignore: deprecated_member_use
                                    style:
                                    textTheme.title.copyWith(fontSize: 100),
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data['description'],
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
                                  '${snapshot.data['windSpeed']}km/h',
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
                                  '${snapshot.data['humidity']}%',
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
                      FutureBuilder<List>(
                        future: fetchForecast,
                        builder: (_,snapshot)=> snapshot.hasData ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => SmallCard(
                              day: _fakeData[index][0],
                              temp: (snapshot.data[index]['temp']['day'] - 273.15).toString().substring(0,2),
                              weatherIcon: _fakeData[index][1],
                            ),
                          ),
                        ) : Container(),
                      ),
                    ],
                  ) : Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Center(
                  child: Text(
                    'Please Give me GPS PERMISSION',
                    style: textTheme.title.copyWith(fontSize: 70),
                  ),
                )),
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
    ],
    [
      'WED',
      WeatherIcons.wiTsunami,
      18,
    ]
  ];
}
