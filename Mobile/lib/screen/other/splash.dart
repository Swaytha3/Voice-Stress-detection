import 'package:flutter/material.dart';
import 'package:relax/onboarding/onboarding_main.dart';
import 'package:relax/screen/main.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splash extends StatefulWidget {
  Splash({
    Key? key,
    this.initScreen,
  }) : super(key: key);
  int? initScreen;
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: widget.initScreen == 0 || widget.initScreen == null
          ? Onboarding()
          : Main(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/logo/logo1.png",
      text: "Relax",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
