import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/AppWidget.dart';
import '../../utils/DTWidgets.dart';

import '../drawer/DTDrawerWidget.dart';
import '../products/DTProductDetailScreen.dart';

class DTCategoryDetailScreen extends StatefulWidget {
  static String tag = '/DTCategoryDetailScreen';

  DTCategoryDetailScreen({super.key, required this.idCat});

  String idCat;

  @override
  DTCategoryDetailScreenState createState() => DTCategoryDetailScreenState();
}

class DTCategoryDetailScreenState extends State<DTCategoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Details'),
      drawer: const DTDrawerWidget(),
      body: FutureBuilder(
        future: getCategoryService(widget.idCat),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List supSer = snapshot.data as List;
            return SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.end,
                runAlignment: WrapAlignment.center,
                children: supSer.map((data) {
                  return Container(
                    decoration: boxDecorationRoundedWithShadow(8,
                        backgroundColor: appStore.appBarColor!),
                    margin: const EdgeInsets.all(8),
                    //height: 200,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 110,
                          child: Stack(
                            children: [
                              Image.network(
                                data['image'],
                                fit: BoxFit.fitHeight,
                                height: isMobile ? 110 : 180,
                                width: context.width(),
                              ).cornerRadiusWithClipRRect(8),
                            ],
                          ),
                        ),
                        8.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(data['name'],
                                style: primaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            4.height,
                            Row(
                              children: [
                                priceWidget(int.parse(data['price'].toString())
                                    // data.discountPrice
                                    ),
                              ],
                            ),
                          ],
                        ).paddingAll(8),
                      ],
                    ),
                  ).onTap(() async {
                    int? index = await DTProductDetailScreen(
                      productModel: data,
                      isFav: false,
                    ).launch(context);
                    if (index != null) appStore.setDrawerItemIndex(index);
                  });
                }).toList(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future getCategoryService(String cat) async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("category")
        .doc(cat)
        .collection('services')
        .where('isAccept', isEqualTo: 1)
        .get();

    return qn.docs;
  }
}
