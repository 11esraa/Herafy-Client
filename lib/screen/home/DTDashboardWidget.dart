import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herafy/screen/login/DTSignUpScreen.dart';
import 'package:herafy/screen/login/login.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppWidget.dart';
import '../../utils/DTWidgets.dart';
import '../DTSearchScreen.dart';
import '../category/DTCategoryDetailScreen.dart';
import '../products/DTProductDetailScreen.dart';

class DTDashboardWidget extends StatefulWidget {
  static String tag = '/DTDashboardWidget';

  const DTDashboardWidget({super.key});

  @override
  DTDashboardWidgetState createState() => DTDashboardWidgetState();
}

class DTDashboardWidgetState extends State<DTDashboardWidget> {
  PageController pageController = PageController();

  List<Widget> pages = [];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget searchTxt() {
      return Container(
        width: dynamicWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: viewLineColor),
          color: appStore.scaffoldBackground,
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(AntDesign.search1, color: appStore.textSecondaryColor),
            10.width,
            Text('Search',
                style: boldTextStyle(color: appStore.textSecondaryColor)),
          ],
        ),
      ).onTap(() {
        const DTSearchScreen().launch(context);
      });
    }

    void addFavServices(data) async {
      FirebaseFirestore.instance.collection('favServices').doc(data['id']).set({
        'image': data['image'],
        "name": data['name'],
        "des": data['des'],
        'type': data['type'],
        'price': data['price'],
        "time": data['time'],
        "craftsman": data['craftsman'],
        "id": data['id'],
        "uid": data['uid'],
      });
    }

    Widget horizontalList() {
      return FutureBuilder(
        future: getCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cat = snapshot.data as List;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 8, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: cat.map((e) {
                  return Container(
                    width: isMobile ? 100 : 300,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Image.network(e['image'],
                              height: 200, width: 300, fit: BoxFit.fill),
                        ),
                        4.height,
                        Text(e['name'],
                            style: primaryTextStyle(
                                size: 18, weight: FontWeight.w900),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ).onTap(() {
                    DTCategoryDetailScreen(
                      idCat: e['name'],
                    ).launch(context);
                  });
                }).toList(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    Widget horizontalProductListView(bool isv) {
      return StreamBuilder(
        stream: isv
            ? FirebaseFirestore.instance.collection('favServices').snapshots()
            : FirebaseFirestore.instance
            .collection('allService')
            .where('isAccept', isEqualTo: 1)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            List ser = snapshot.data?.docs as List;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index1) {
                return Container(
                  decoration: boxDecorationRoundedWithShadow(8,
                      backgroundColor: appStore.appBarColor!),
                  width: 220,
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.height,
                      Stack(
                        children: [
                          Image.network(
                            ser[index1]['image'],
                            fit: BoxFit.fitHeight,
                            height: 180,
                            width: context.width(),
                          ).cornerRadiusWithClipRRect(8),
                        ],
                      ).expand(),
                      8.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(ser[index1]['name'],
                                    style: primaryTextStyle(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              !isv
                                  ? ElevatedButton.icon(
                                onPressed:
                                FirebaseAuth.instance.currentUser !=
                                    null
                                    ? () {
                                  FirebaseFirestore.instance
                                      .collection('allService')
                                      .doc(ser[index1]['id'])
                                      .set(
                                    {
                                      'add': [
                                        FirebaseAuth.instance
                                            .currentUser!.uid
                                      ],
                                    },
                                    SetOptions(merge: true),
                                  );
                                  addFavServices(ser[index1]);
                                }
                                    : () {},
                                icon: const Icon(Icons.add),
                                label: const Text('Fav'),
                              )
                                  : Container(),
                            ],
                          ),
                          4.height,
                          Row(
                            children: [
                              8.width,
                              priceWidget(
                                  int.parse(ser[index1]['price'].toString()),
                                  applyStrike: false),
                            ],
                          ),
                        ],
                      ).paddingAll(8),
                      10.height,
                    ],
                  ),
                ).onTap(() async {
                  int? index = await DTProductDetailScreen(
                    productModel: ser[index1],
                    isFav: true,
                  ).launch(context);
                  if (index != null) appStore.setDrawerItemIndex(index);
                });
              },
              /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.width() > 1550
                            ? 4
                            : context.width() > 1080
                                ? 3
                                : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: cardWidth / cardHeight,
                      ),*/
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: ser.length,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    Widget mobileWidget() {
      return SingleChildScrollView(
        child: Container(),
      );
    }

    Widget webWidget() {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/logo.png",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                searchTxt().expand(),
                25.width,
                FirebaseAuth.instance.currentUser == null
                    ? Container(
                  padding: const EdgeInsets.only(
                      top: 8, left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      color: appColorPrimary,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('Sign In',
                      style: boldTextStyle(color: white, size: 18)),
                ).onTap(() {
                  LoginPage().launch(context);
                })
                    : Container(),
                16.width,
                FirebaseAuth.instance.currentUser == null
                    ? Container(
                  padding: const EdgeInsets.only(
                      top: 8, left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      color: appColorPrimary,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('Register',
                      style: boldTextStyle(color: white, size: 18)),
                ).onTap(() {
                  DTSignUpScreen().launch(context);
                })
                    : Container(),
                16.width
              ],
            ),
            Text('Category ', style: boldTextStyle()).paddingAll(8),
            8.height,
            horizontalList(),
            8.height,
            Text('Service For you', style: boldTextStyle()).paddingAll(8),
            8.height,
            SizedBox(height: 300, child: horizontalProductListView(false)),
            8.height,
            // Text('Latest Offers For You', style: boldTextStyle()).paddingAll(8),
            // 8.height,
            // // bannerWidget(),
            8.height,
            Text('Recommended For You', style: boldTextStyle()).paddingAll(8),
            8.height,
            SizedBox(height: 300, child: horizontalProductListView(true)),
            // Text('Recommended Offers For You', style: boldTextStyle()).paddingAll(8),
            // 8.height,
            // bannerWidget(),
          ],
        ),
      );
    }

    return Scaffold(
      body: ContainerX(
        mobile: mobileWidget(),
        web: webWidget(),
      ),
    );
  }

  Future getCategory() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("category").get();

    return qn.docs;
  }

  getAllServices() async {
    var firestore = FirebaseFirestore.instance;
    var qn = await firestore
        .collection("allService")
        .where('isAccept', isEqualTo: true)
        .snapshots();

    return qn;
  }

  getFavServices() async {
    var firestore = FirebaseFirestore.instance;
    return firestore.collection("favServices").snapshots();
  }
}
