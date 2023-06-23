import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herafy/screen/login/login.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../screen/about/DTAboutScreen.dart';
import '../screen/login/DTSignUpScreen.dart';
import '../screen/order/orders.dart';
import '../screen/profile/DTContactUsScreen.dart';
import '../screen/profile/DTProfileScreen.dart';
import '../store/ListModels.dart';

const sender_id = 1;
const receiver_id = 2;



int getDTWidgetIndex(Widget widget) {
  getDrawerItems().asMap().entries.map((e) {
    int index = e.key;

    if (e.value.widget == widget) {
      return index;
    }
    return -1;
  });
  return -1;

}

List<ListModel> getDrawerItems() {
  List<ListModel> drawerItems = [];


  FirebaseAuth.instance.currentUser == null
      ? drawerItems.add(ListModel(name: 'Sign In', widget: const LoginPage()))
      : null;

  FirebaseAuth.instance.currentUser == null
      ? drawerItems
          .add(ListModel(name: 'Sign Up', widget: const DTSignUpScreen()))
      : null;

  FirebaseAuth.instance.currentUser != null
      ? drawerItems
          .add(ListModel(name: 'Profile', widget: const DTProfileScreen()))
      : null;

  FirebaseAuth.instance.currentUser != null
      ? drawerItems.add(ListModel(
          name: 'Contracts',
          widget: const Orders(
            deviceScreenType: DeviceScreenType.desktop,
          )))
      : null;

  drawerItems.add(ListModel(name: 'About', widget: const DTAboutScreen()));


  drawerItems.add(ListModel(name: 'Contact Us', widget: const DTContactUsScreen()));

  return drawerItems;
}


String getMonth(int month) {
  if (month == 1) return 'January';
  if (month == 2) return 'February';
  if (month == 3) return 'March';
  if (month == 4) return 'April';
  if (month == 5) return 'May';
  if (month == 6) return 'Jun';
  if (month == 7) return 'July';
  if (month == 8) return 'August';
  if (month == 9) return 'September';
  if (month == 10) return 'October';
  if (month == 11) return 'November';
  if (month == 12) return 'December';
  return '';
}


