import 'package:flutter/material.dart';
import 'package:quiz_app/Quiz/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login/loginScreen.dart';
import 'config/get_it_config.dart';

void main()  {
  init();
  runApp(const MyApp());
  //await clearSharedPreferences();
  //if the app Habd just clear the shared preferences and try again 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (core.get<SharedPreferences>().getString('name') == null)
          ? LoginScreen()
          : Quiz()
    );
  }
}
