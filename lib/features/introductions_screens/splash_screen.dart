import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sheek/features/introductions_screens/on_boarding_screens.dart';
import 'package:sheek/sections_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset(
            'assets/images/icon.png',
            width: 100,
            height: 100,
          ),
          const Text(
            "Sheek Bazar",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          )
        ],
      ),
      nextScreen: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            var token = snapshot.data?.getString('USER_ID');
            if (token != null) {
              return const SectionsScreen();
            } else {
              return const Onbording();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      backgroundColor: Colors.white,
      splashIconSize: 250,
      duration: 500,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
