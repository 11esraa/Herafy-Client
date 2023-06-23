import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herafy/screen/profile/DTChangePasswordScreen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/AppWidget.dart';

import '../drawer/DTDrawerWidget.dart';

class DTSecurityScreen extends StatefulWidget {
  static String tag = '/DTSecurityScreen';

  const DTSecurityScreen({super.key});

  @override
  DTSecurityScreenState createState() => DTSecurityScreenState();
}

class DTSecurityScreenState extends State<DTSecurityScreen> {
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Security'),
      drawer: const DTDrawerWidget(),
      body: Column(
        children: [
          settingItem(context, 'Change Password', onTap: () {
            const DTChangePasswordScreen().launch(context);
          }, leading: const Icon(AntDesign.lock), detail: const SizedBox()),
        ],
      ),
    );
  }
}
