import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SmallCard extends StatelessWidget {
  SmallCard({@required this.day,@required this.temp,@required this.weatherIcon});

  final String day;
  final IconData weatherIcon;
  final int temp;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // ignore: deprecated_member_use
          Text(day,style: textTheme.subtitle,),
          Icon(weatherIcon,color: color,),
          // ignore: deprecated_member_use
          Text('$temp°',style: textTheme.title,),
        ],
      ),
    );
  }
}
