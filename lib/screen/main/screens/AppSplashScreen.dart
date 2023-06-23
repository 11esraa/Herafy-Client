import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herafy/screen/home/DTDashboardScreen.dart';
import 'package:herafy/screen/main/utils/AppConstant.dart';
import 'package:nb_utils/nb_utils.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/ProkitSplashScreen';

  const AppSplashScreen({super.key});

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  void navigationPage() async {
    setValue(appOpenCount, (getIntAsync(appOpenCount)) + 1);

    if (!await isNetworkAvailable()) {
      toastLong(errorInternetNotAvailable);
    }

    await Future.delayed(const Duration(seconds: 3));
    if (isWeb) {
      DTDashboardScreen().launch(context, isNewTask: true);
    } else {
      // ProKitLauncher().launch(context, isNewTask: true);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorFromHex('#FFFDF1'),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            image:const DecorationImage( image: AssetImage(
              "images/logo.jpg",
            ) ,fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
