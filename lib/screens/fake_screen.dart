import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/fake_provider.dart';

class FakeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FakeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('X is : ${prov.x}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Icons.remove), onPressed: (){
                prov.decrement();
              }),
              IconButton(icon: Icon(Icons.add), onPressed: ()=> prov.increment()),
            ],
          )
        ],
      ),
    );
  }
}
