import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gect_hackathon/screens/capture_screen.dart';
import 'package:gect_hackathon/screens/homeScreen.dart';
import 'package:gect_hackathon/screens/loginScreen.dart';
import 'package:gect_hackathon/screens/splashScreen.dart';
import 'package:gect_hackathon/utilis/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isSignedIn = false;
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     isSignedIn = false;
    //     print("Not signed in");
    //     Navigator.of(context).popAndPushNamed('/login');
    //   } else {
    //     print('User is signed in!');
    //     isSignedIn = true;
    //     Navigator.of(context).popAndPushNamed('/home-screen');
    //   }
    // });
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TextRecognitionState())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: colorPrimary,
              primaryColorLight: colorPrimary20,
              primaryColorDark: colorDark,
              textTheme: textThemeDefault),
          title: 'Pocket Tracker',
          home: SafeArea(child: MainPage()),
          routes: routes,
        ));
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          print("####################");
          print(snapshot.data);
          return HomeScreen();
        } else {
          return SplashScreen();
        }
      }),
      stream: FirebaseAuth.instance.authStateChanges(),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();

//     if (firebaseUser != null) {
//       return HomeScreen();
//     } else {
//       return LoginScreen();
//     }
//   }
// }

// class AuthenticationServices {
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationServices(this._firebaseAuth);

//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   Future<String> signIn({String? email, String? password}) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email!, password: password!);
//       return "Signed-In";
//     } on FirebaseAuthException catch (e) {
//       return e.message!;
//     }
//   }

//   Future<String> signUp({String? email, String? password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email!, password: password!);
//       return "Signed-Up";
//     } on FirebaseAuthException catch (e) {
//       return e.message!;
//     }
//   }
// }
