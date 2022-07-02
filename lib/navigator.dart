import 'package:flutter/material.dart';
import 'package:gect_hackathon/screens/splashScreen.dart';
import './screens/screens.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splashScreen': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignupScreen(),
  '/home-screen': (context) => HomeScreen(),
};
