import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/AppColors.dart';
import '../utils/AppWidget.dart';
import '../utils/DTWidgets.dart';
import 'drawer/DTDrawerWidget.dart';
import 'products/DTProductDetailScreen.dart';

class DTSearchScreen extends StatefulWidget {
  const DTSearchScreen({super.key});

  @override
  _DTSearchScreenState createState() => _DTSearchScreenState();
}

class _DTSearchScreenState extends State<DTSearchScreen> {
  var searchCont = TextEditingController();
  List<String> recentSearch = [];
  List<String> trending = [];

  String searchText = '';

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
    return Scaffold(
      appBar: appBar(context, 'Search'),
      drawer: const DTDrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: searchCont,
              style: primaryTextStyle(),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: primaryTextStyle(color: appStore.textSecondaryColor),
                contentPadding: const EdgeInsets.all(16),
                prefixIcon:
                    Icon(AntDesign.search1, color: appStore.textSecondaryColor),
                labelStyle: secondaryTextStyle(),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: appColorPrimary)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(color: appStore.textSecondaryColor!)),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              onChanged: (String searchTxt) {
                searchText = searchTxt;
                setState(() {});
                // searchDocuments(searchText);
              },
            ),
            16.height,
            SizedBox(
                height: 300,
                child: horizontalProductListView(
                    false, searchCont.text.toString()))
          ],
        ),
      ),
    );
  }

  Widget horizontalProductListView(bool isv, String search) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('allService')
          .where('name', isEqualTo: searchText)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List ser = snapshot.data!.docs;
          print(ser);
          print(searchText);
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
                            Text(ser[index1]['name'],
                                style: primaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        4.height,
                        Row(
                          children: [
                            8.width,
                            priceWidget(
                                int.parse(ser[index1]['price'].toString()),
                                applyStrike: true),
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

  searchDocuments(String query) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('allService')
        .where('name', isEqualTo: query.toLowerCase())
        .get();
    return snapshot.docs;
  }
}
