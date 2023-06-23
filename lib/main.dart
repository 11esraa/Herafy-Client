import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:herafy/screen/main/screens/AppSplashScreen.dart';
import 'package:herafy/screen/main/utils/AppConstant.dart';
import 'package:herafy/screen/main/utils/AppTheme.dart';
import 'package:nb_utils/nb_utils.dart';

import 'store/AppStore.dart';

AppStore appStore = AppStore();

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialize();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  runApp(MyApp());
  //endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) =>
          GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: '$mainAppName${!isMobile ? ' ${platformName()}' : ''}',
            home: const AppSplashScreen(),
            theme: !appStore.isDarkModeOn
                ? AppThemeData.lightTheme
                : AppThemeData.darkTheme,
            scrollBehavior: CustomScrollBehaviour(),
          ),
    );
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
