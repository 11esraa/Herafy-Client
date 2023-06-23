import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/AppImages.dart';
import '../../../utils/AppWidget.dart';
import '../../home/DTDashboardScreen.dart';
import '../model/AppModel.dart';
import 'SettingScreen.dart';

class ProKitWebLauncher extends StatefulWidget {
  static String tag = '/ProKitWebLauncher';

  @override
  ProKitWebLauncherState createState() => ProKitWebLauncherState();
}

class ProKitWebLauncherState extends State<ProKitWebLauncher> {
  List<ProTheme> list = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    list.add(ProTheme(name: 'Default Theme', type: '', show_cover: false, widget: DTDashboardScreen(), darkThemeSupported: true));

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [appCat1, appCat2, appCat3];

    return Observer(
      builder: (_) => Scaffold(
        appBar: appBar(
          context,
          'Dashboard',
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: appStore.backgroundColor),
              onPressed: () {
                SettingScreen().launch(context);
              },
            )
          ],
          showBack: false,
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: list
                  .asMap()
                  .map(
                    (index, e) {
                      return MapEntry(
                        index,
                        Container(
                          height: 200,
                          width: 200,
                          margin: EdgeInsets.all(8),
                          decoration: boxDecoration(bgColor: colors[index % colors.length], radius: 4),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(icons[index], color: Colors.white, height: 100),
                              16.height,
                              Text(e.name!, style: boldTextStyle(size: 20, color: Colors.white)),
                            ],
                          ),
                        ).onTap(() {
                          e.widget.launch(context);
                        }),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
