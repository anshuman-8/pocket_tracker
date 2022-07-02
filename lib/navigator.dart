import 'package:flutter/material.dart';
import './screens/screens.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignupScreen(),
  '/home-screen': (context) => HomeScreen(),
};
