import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:herafy/screen/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';


class MWDrawerScreen2 extends StatefulWidget {
  static String tag = '/MWDrawerScreen2';

  const MWDrawerScreen2({super.key});

  @override
  _MWDrawerScreen2State createState() => _MWDrawerScreen2State();
}

class _MWDrawerScreen2State extends State<MWDrawerScreen2> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 1));
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: appStore.appBarColor,
        title: Text('With Custom Shape', style: TextStyle(color: appStore.textPrimaryColor, fontSize: 22)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              color: appStore.appBarColor,
            ),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: appStore.textPrimaryColor,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState!.openEndDrawer();
                        },
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.orange),
                        image: const DecorationImage(image: CachedNetworkImageProvider('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTD8u1Nmrk78DSX0v2i_wTgS6tW5yvHSD7o6g&usqp=CAU')),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "",
                      style: TextStyle(color: appStore.textPrimaryColor, fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    Text("", style: TextStyle(color: appStore.textPrimaryColor, fontSize: 16.0)),
                    30.height,
                    itemList(Icon(Icons.home, color: appStore.iconColor), "Home"),
                    const Divider(),
                    15.height,
                    itemList(Icon(Icons.person_pin, color: appStore.iconColor), "My profile"),
                    const Divider(),
                    15.height,
                    itemList(Icon(Icons.message, color: appStore.iconColor), "Messages"),
                    const Divider(),
                    15.height,
                    itemList(Icon(Icons.notifications, color: appStore.iconColor), "Notifications"),
                    const Divider(),
                    15.height,
                    itemList(Icon(Icons.settings, color: appStore.iconColor), "Settings"),
                    const Divider(),
                    15.height,
                    itemList(Icon(Icons.email, color: appStore.iconColor), "Contact us"),
                    const Divider(),
                    15.height,
                    itemList(Icon(Icons.info_outline, color: appStore.iconColor), "Help"),
                    const Divider(),
                    15.height,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: MaterialButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        padding: const EdgeInsets.all(16),
        color: appColorPrimary,
        child: Text('Open Drawer', style: primaryTextStyle(color: whiteColor)),
      ).center(),
    );
  }

  Widget itemList(Widget icon, String title) {
    return Row(
      children: [
        icon,
        10.width,
        Text(title, style: TextStyle(color: appStore.textPrimaryColor)),
      ],
    ).onTap(() {
      scaffoldKey.currentState!.openEndDrawer();
      toast(title);
    });
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4), size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
