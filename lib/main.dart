import 'package:flutter/material.dart';
import 'package:yeong_twitter/constants/sizes.dart';
import 'package:yeong_twitter/features/authentication/a_whats_happening_screen.dart';
import 'package:yeong_twitter/features/authentication/b_sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(
        userData: {
          "name": "Yeong",
          "email": "yeong@naver.com",
          "birthday": "2003-02-28",
        },
        customize: true,
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF6196E3),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF6196E3),
          elevation: 0,
          centerTitle: true,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          elevation: 0,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.d32,
            vertical: Sizes.d10,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d20,
            letterSpacing: -0.025,
          ),
          titleMedium: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d18,
            letterSpacing: -0.025,
          ),
          titleSmall: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d16,
            letterSpacing: -0.025,
          ),
          bodyLarge: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d18,
            letterSpacing: -0.025,
          ),
          bodyMedium: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d16,
            letterSpacing: -0.025,
          ),
          bodySmall: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d14,
            letterSpacing: -0.025,
          ),
          labelLarge: TextStyle(
            fontFamily: "PretendardSemibold",
            fontSize: Sizes.d14,
            letterSpacing: -0.025,
          ),
          labelSmall: TextStyle(
            fontFamily: "PretendardMedium",
            fontSize: Sizes.d12,
            letterSpacing: -0.025,
          ),
        ),
      ),
    );
  }
}
