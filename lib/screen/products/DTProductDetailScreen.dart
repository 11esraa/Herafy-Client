import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herafy/screen/login/login.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppWidget.dart';
import '../../utils/DTWidgets.dart';
import 'ReviewWidget.dart';
import '../drawer/DTDrawerWidget.dart';
import '../order/order_info.dart';
import 'DTReviewScreen.dart';

// ignore: must_be_immutable
class DTProductDetailScreen extends StatefulWidget {
  static String tag = '/DTProductDetailScreen';
  final productModel;
  final bool isFav;

  const DTProductDetailScreen(
      {super.key, required this.productModel, required this.isFav});

  @override
  DTProductDetailScreenState createState() => DTProductDetailScreenState();
}

class DTProductDetailScreenState extends State<DTProductDetailScreen> {
  var discount = 15.0;


  @override
  void initState() {
    super.initState();
    // init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Widget buyNowBtn() {
      return FirebaseAuth.instance.currentUser != null
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    alignment: Alignment.center,
                    width: context.width() / 2,
                    decoration: BoxDecoration(
                        color: appColorPrimary, boxShadow: defaultBoxShadow()),
                    child:
                        Text('Order Now', style: boldTextStyle(color: white)),
                  ).onTap(data['isAccept']
                      ? () async {
                          OrderInfo(
                            productModel: widget.productModel,
                          ).launch(context);
                        }
                      : null);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
          : Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.center,
              width: context.width() / 2,
              decoration: BoxDecoration(
                  color: appColorPrimary, boxShadow: defaultBoxShadow()),
              child: Text('Order Now', style: boldTextStyle(color: white)),
            ).onTap(() {
              // Do your logic
              const LoginPage().launch(context);
              // DTPaymentScreen(
              //   data: widget.productModel,
              // ).launch(context);
            });
    }

    Widget productDetail() {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.productModel['name'], style: boldTextStyle(size: 18)),
              10.height,
              Text(
                'CraftsMan : ${widget.productModel['craftsman']}',
                style: const TextStyle(fontSize: 18),
              ),
              10.height,
              FirebaseAuth.instance.currentUser != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              priceWidget(
                                  int.parse(widget.productModel['price'] ),
                                  fontSize: 28,
                                  textColor: appColorPrimary),
                              8.width,
                              // priceWidget(int.parse(widget.productModel['price']),
                              //     applyStrike: true, fontSize: 18),


                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        priceWidget(
                            int.parse(widget.productModel['price'].toString()),
                            fontSize: 28,
                            textColor: appColorPrimary),
                      ],
                    ),
              10.height,
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: appColorPrimary,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.star_border,
                            color: Colors.white, size: 14),
                        8.width,
                      ],
                    ),
                  ).onTap(() {
                    DTReviewScreen(id: widget.productModel['id'])
                        .launch(context);
                  }),
                  8.width,
                ],
              ),
            ],
          ).paddingAll(16),
          const Divider(height: 20),
          Text(widget.productModel['des'], style: boldTextStyle(size: 18)),
        ],
      );
    }

    Widget mobileWidget() {
      return Container();
    }

    Widget webWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  16.height,
                  Container(
                    height: context.height() * 0.45,
                    margin: const EdgeInsets.all(8),
                    child: Image.network(
                      widget.productModel['image'],
                      width: context.width(),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buyNowBtn().expand(flex: 20),
                    ],
                  ),
                ],
              ).expand(flex: 40),
              const VerticalDivider(width: 0),
              Container(
                decoration: boxDecoration(bgColor: appStore.scaffoldBackground),
                child: SingleChildScrollView(
                  child: productDetail(),
                ),
              ).expand(flex: 60),
            ],
          ),
          16.height,
          widget.productModel != null
              ? Text('${widget.productModel['name']} Reviews',
                      style: boldTextStyle())
                  .paddingAll(16)
              : const SizedBox(),
          StreamBuilder(
              stream: widget.isFav
                  ? FirebaseFirestore.instance
                      .collection('allService')
                      .doc(widget.productModel['id'])
                      .collection('review')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('allService')
                      .doc(widget.productModel['id'])
                      .collection('review')
                      .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data!.docs;
                  return ReviewWidget(list: data);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      );
    }

    return Scaffold(
      appBar: appBar(context, 'Detail'),
      drawer: const DTDrawerWidget(),
      body: ContainerX(
        mobile: mobileWidget(),
        web: SingleChildScrollView(child: webWidget()),
        useFullWidth: true,
      ),
    );
  }
}

// void mMoreOfferBottomSheet(BuildContext aContext) {
//   showModalBottomSheet(
//     context: aContext,
//     backgroundColor: appStore.scaffoldBackground,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//     ),
//     builder: (builder) {
//       return SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             16.height,
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(MaterialCommunityIcons.truck_delivery,
//                     color: appColorPrimary),
//                 10.width,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("\$10 Delivery in 2 days, Monday",
//                         style: boldTextStyle()),
//                     4.height,
//                     Text(
//                       LoremText,
//                       style: secondaryTextStyle(size: 14),
//                       maxLines: 2,
//                     ),
//                   ],
//                 ).expand()
//               ],
//             ),
//             16.height,
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(FontAwesome.exchange, color: appColorPrimary),
//                 10.width,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("7 Days return policy", style: boldTextStyle()),
//                     4.height,
//                     Text(
//                       LoremText,
//                       style: secondaryTextStyle(size: 14),
//                       maxLines: 2,
//                     ),
//                   ],
//                 ).expand()
//               ],
//             ),
//             16.height,
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(MaterialIcons.attach_money, color: appColorPrimary),
//                 10.width,
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Cash on Delivery", style: boldTextStyle()),
//                     4.height,
//                     Text(
//                       LoremText,
//                       style: secondaryTextStyle(size: 14),
//                       maxLines: 2,
//                     ),
//                   ],
//                 ).expand()
//               ],
//             ),
//             16.height,
//           ],
//         ),
//       );
//     },
//   );
// }
