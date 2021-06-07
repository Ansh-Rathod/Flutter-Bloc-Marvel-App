import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:marvelapp/screens/bottomNavVeiw.dart';
import 'blocs/fetch_home/fetch_home_bloc.dart';
import 'screens/home.dart';
import 'screens/all_characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
        primaryColor: Colors.red,
        accentColor: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: GoogleFonts.montserratTextTheme(),
          titleTextStyle: GoogleFonts.montserrat(
            color: Colors.black,
          ),
        ),
      ),
      home: BottomNavView(),
    );
  }
}
