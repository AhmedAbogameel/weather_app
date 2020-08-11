import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/fake_provider.dart';
import 'package:weather_app/screens/fake_screen.dart';
import 'package:weather_app/screens/home_screen.dart';

void main()=>
  runApp(
    DevicePreview(
      builder: (context) => EntryPoint(),
    ),
  );


class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> FakeProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.blue,
            textTheme: ThemeData().textTheme.copyWith(
              title: TextStyle(color: Colors.pink),
              subtitle: TextStyle(color: Colors.pink.withOpacity(0.5)),
            )
        ),
        home: HomeScreen(),
        routes: {
          'fake':(_)=> FakeScreen(),
        },
      ),
    );
  }
}
