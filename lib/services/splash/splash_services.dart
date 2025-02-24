import 'package:assignment_2/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashServices {
void navigateToNextScreen(BuildContext context) {
  Future.delayed(Duration(seconds: 3), () {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.homeScreen, (route) => false);
  });
}
}