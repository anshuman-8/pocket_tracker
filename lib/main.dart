import 'package:flutter/material.dart';
import 'package:gect_hackathon/screens/capture_screen.dart';
import 'package:gect_hackathon/screens/homeScreen.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TextRecognitionState())
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: colorPrimary,
              primaryColorLight: colorPrimary20,
              primaryColorDark: colorDark,
              textTheme: textThemeDefault),
          title: 'Flutter Demo',
          home:  SafeArea(child: HomeScreen()),
        ));
  }
}
