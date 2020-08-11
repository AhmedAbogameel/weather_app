import 'package:flutter/material.dart';

class FakeProvider with ChangeNotifier{

    int x = 0;

    void increment(){
      x++;
      notifyListeners();
    }

    void decrement(){
      x--;
      notifyListeners();
    }

}