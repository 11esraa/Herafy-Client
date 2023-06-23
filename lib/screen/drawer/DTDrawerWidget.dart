import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herafy/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../store/ListModels.dart';
import '../../utils/AppColors.dart';
import '../../utils/DTDataProvider.dart';
import '../home/DTDashboardScreen.dart';
import '../main/screens/AppSplashScreen.dart';
import 'MWDrawerScreen2.dart';


class DTDrawerWidget extends StatefulWidget {
  static String tag = '/DTDrawerWidget';

  const DTDrawerWidget({super.key});

  @override
  DTDrawerWidgetState createState() => DTDrawerWidgetState();
}

class DTDrawerWidgetState extends State<DTDrawerWidget> {
  List<ListModel> drawerItems = getDrawerItems();
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (appStore.selectedDrawerItem > 7) {
      await Future.delayed(const Duration(milliseconds: 300));
      scrollController.jumpTo(appStore.selectedDrawerItem * 27.0);

      setState(() {});
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            color: appStore.scaffoldBackground,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  16.height,
                  Text('Screens', style: secondaryTextStyle(size: 12))
                      .paddingOnly(left: 16),
                  4.height,
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text('Home',
                        style: boldTextStyle(color: appColorPrimary)),
                  ).onTap(() {
                    appStore.setDrawerItemIndex(-1);

                    if (isMobile) {
                      const DTDashboardScreen()
                          .launch(context, isNewTask: true);
                    } else {
                      const DTDashboardScreen()
                          .launch(context, isNewTask: true);
                    }
                  }),
                  const Divider(height: 16, color: viewLineColor),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: appStore.selectedDrawerItem == index
                              ? appColorPrimary.withOpacity(0.3)
                              : appStore.scaffoldBackground,
                        ),
                        child: Text(
                          drawerItems[index].name!,
                          style: boldTextStyle(
                              color: appStore.selectedDrawerItem == index
                                  ? appColorPrimary
                                  : appStore.textPrimaryColor),
                        ),
                      ).onTap(() {
                        finish(context);
                        appStore.setDrawerItemIndex(index);

                        drawerItems[index].widget.launch(context);
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    itemCount: drawerItems.length,
                    shrinkWrap: true,
                  ),
                  FirebaseAuth.instance.currentUser != null
                      ? Row(
                          children: const [
                            Icon(Icons.login_outlined),
                            Text(
                              'Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ],
                        ).onTap(() async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            const AppSplashScreen().launch(context);
                          });
                        })
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
