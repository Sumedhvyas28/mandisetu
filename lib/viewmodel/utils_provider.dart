import 'package:flutter/cupertino.dart';

class UtilsProvider extends ChangeNotifier{

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  setCurrentIndex(int value){
    _currentIndex = value;
    notifyListeners();
  }




}