  // ignore: file_names
import 'package:flutter/material.dart';
import 'package:whatdo/themes/dark_mode.dart';
import 'package:whatdo/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get  themeData => _themeData;
bool get isDarkMode => themeData == darkMode;
set themeData (ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
}
void themeToggle(){
if(_themeData == lightMode){
  themeData = darkMode;
}
else{
  themeData = lightMode;
}
}
}