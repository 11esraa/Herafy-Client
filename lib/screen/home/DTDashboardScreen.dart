import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../../utils/AppWidget.dart';
import '../drawer/DTDrawerWidget.dart';
import 'DTDashboardWidget.dart';

class DTDashboardScreen extends StatefulWidget {
  static String tag = '/DTDashboardScreen';

  const DTDashboardScreen({super.key});

  @override
  DTDashboardScreenState createState() => DTDashboardScreenState();
}

class DTDashboardScreenState extends State<DTDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (context) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appStore.appBarColor,
            title: appBarTitleWidget(context, 'Dashboard'),
          ),
          drawer: const DTDrawerWidget(),
          body: const DTDashboardWidget(),
        ),
      ),
    );
  }
}
