import 'package:VirtualLibrary/UI/login/user_form.dart';
import 'package:flutter/material.dart';
import 'package:VirtualLibrary/UI/login/splash_screen.dart';

void main()=>runApp(MyApp());

class  MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Color(0xff59bfff),
        accentColor: Color(0xff59bfff),
      ),
      home: SplashScreen()
    );
  }
}
