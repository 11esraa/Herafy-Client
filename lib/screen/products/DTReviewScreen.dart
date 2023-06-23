import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herafy/screen/login/login.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppWidget.dart';
import '../../utils/DTWidgets.dart';

import 'ReviewWidget.dart';
import '../drawer/DTDrawerWidget.dart';
import '../main/utils/flutter_rating_bar.dart';

class DTReviewScreen extends StatefulWidget {
  static String tag = '/DTReviewScreen';

  DTReviewScreen({super.key, required this.id});

  String id;

  @override
  DTReviewScreenState createState() => DTReviewScreenState();
}

class DTReviewScreenState extends State<DTReviewScreen> {
  var scrollController = ScrollController();

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
    Widget reviewListing() {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('allService')
              .doc(widget.id)
              .collection('review')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data?.docs;
              return ReviewWidget(list: data);
            } else {
              return const CircularProgressIndicator();
            }
          });
    }

    Widget mobileWidget() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(gradient: defaultThemeGradient()),
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: dynamicBoxConstraints(),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                            child: Text('4.2',
                                style: boldTextStyle(size: 40, color: white))),
                        IgnorePointer(
                          child: RatingBar(
                            onRatingUpdate: (r) {},
                            itemSize: 14.0,
                            itemBuilder: (context, _) => const Icon(
                                Icons.star_border,
                                color: Colors.amber),
                            initialRating: 0.0,
                          ),
                        ),
                        10.height,
                        FittedBox(
                            child: Text(
                                Random()
                                    .nextInt(50000000)
                                    .toString()
                                    .formatNumberWithComma(),
                                style: boldTextStyle(color: white))),
                      ],
                    ).paddingOnly(left: 8, right: 8).expand(flex: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('5', style: primaryTextStyle(color: white)),
                            10.width,
                            LinearProgressIndicator(
                              value: 0.6,
                              backgroundColor: white.withOpacity(0.2),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(white),
                            ).expand(),
                            10.width,
                          ],
                        ),
                        Row(
                          children: [
                            Text('4', style: primaryTextStyle(color: white)),
                            10.width,
                            LinearProgressIndicator(
                              value: 0.4,
                              backgroundColor: white.withOpacity(0.2),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(white),
                            ).expand(),
                            10.width,
                          ],
                        ),
                        Row(
                          children: [
                            Text('3', style: primaryTextStyle(color: white)),
                            10.width,
                            LinearProgressIndicator(
                              value: 0.9,
                              backgroundColor: white.withOpacity(0.2),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(white),
                            ).expand(),
                            10.width,
                          ],
                        ),
                        Row(
                          children: [
                            Text('2', style: primaryTextStyle(color: white)),
                            10.width,
                            LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: white.withOpacity(0.2),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(white),
                            ).expand(),
                            10.width,
                          ],
                        ),
                        Row(
                          children: [
                            Text('1', style: primaryTextStyle(color: white)),
                            10.width,
                            LinearProgressIndicator(
                              value: 0.2,
                              backgroundColor: white.withOpacity(0.2),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(white),
                            ).expand(),
                            10.width,
                          ],
                        ),
                      ],
                    ).expand(flex: 2),
                  ],
                ),
              ),
            ),
            8.height,
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Write a Review',
                  style: boldTextStyle(color: appColorPrimary)),
            ).onTap(() async {
              await showInDialog(context,
                  child: WriteReviewDialog(id: widget.id),
                  backgroundColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(0));

              setState(() {});
            }),
            reviewListing(),
          ],
        ),
      );
    }

    Widget webWidget() {
      return Row(
        children: [
          16.width,
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 200,
                    width: dynamicWidth(context),
                    decoration: BoxDecoration(
                        gradient: defaultThemeGradient(),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: dynamicBoxConstraints(),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                  child: Text('4.2',
                                      style: boldTextStyle(
                                          size: 40, color: white))),
                              IgnorePointer(
                                child: RatingBar(
                                  onRatingUpdate: (r) {},
                                  itemSize: 14.0,
                                  itemBuilder: (context, _) => const Icon(
                                      Icons.star_border,
                                      color: Colors.amber),
                                  initialRating: 0.0,
                                ),
                              ),
                              10.height,
                              FittedBox(
                                  child: Text(
                                      Random()
                                          .nextInt(50000000)
                                          .toString()
                                          .formatNumberWithComma(),
                                      style: boldTextStyle(color: white))),
                            ],
                          ).paddingOnly(left: 8, right: 8).expand(flex: 1),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text('5',
                                      style: primaryTextStyle(color: white)),
                                  10.width,
                                  LinearProgressIndicator(
                                    value: 0.6,
                                    backgroundColor: white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            white),
                                  ).expand(),
                                  10.width,
                                ],
                              ),
                              Row(
                                children: [
                                  Text('4',
                                      style: primaryTextStyle(color: white)),
                                  10.width,
                                  LinearProgressIndicator(
                                    value: 0.4,
                                    backgroundColor: white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            white),
                                  ).expand(),
                                  10.width,
                                ],
                              ),
                              Row(
                                children: [
                                  Text('3',
                                      style: primaryTextStyle(color: white)),
                                  10.width,
                                  LinearProgressIndicator(
                                    value: 0.9,
                                    backgroundColor: white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            white),
                                  ).expand(),
                                  10.width,
                                ],
                              ),
                              Row(
                                children: [
                                  Text('2',
                                      style: primaryTextStyle(color: white)),
                                  10.width,
                                  LinearProgressIndicator(
                                    value: 0.8,
                                    backgroundColor: white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            white),
                                  ).expand(),
                                  10.width,
                                ],
                              ),
                              Row(
                                children: [
                                  Text('1',
                                      style: primaryTextStyle(color: white)),
                                  10.width,
                                  LinearProgressIndicator(
                                    value: 0.2,
                                    backgroundColor: white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            white),
                                  ).expand(),
                                  10.width,
                                ],
                              ),
                            ],
                          ).expand(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  16.height,
                  Container(
                    alignment: Alignment.center,
                    width: dynamicWidth(context),
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('Write a Review',
                        style: boldTextStyle(color: appColorPrimary)),
                  ).onTap(() async {
                    await showInDialog(context,
                        child: WriteReviewDialog(
                          id: widget.id,
                        ),
                        backgroundColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(0));

                    setState(() {});
                  }),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: reviewListing(),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: appBar(context, 'Review & Rating'),
      drawer: const DTDrawerWidget(),
      body: ContainerX(
        mobile: mobileWidget(),
        web: webWidget(),
      ),
    );
  }
}

// ignore: must_be_immutable
class WriteReviewDialog extends StatelessWidget {
  var reviewCont = TextEditingController();
  var reviewFocus = FocusNode();
  double ratting = 0.0;
  String id;

  WriteReviewDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: dynamicBoxConstraints(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: appStore.scaffoldBackground,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Write a Review', style: boldTextStyle(size: 18)),
                  IconButton(
                    icon: Icon(Icons.close, color: appStore.iconColor),
                    onPressed: () {
                      finish(context);
                    },
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  finish(context);
                },
                child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.centerRight),
              ),
              8.height,
              Center(
                child: RatingBar(
                  onRatingUpdate: (r) {
                    ratting = r;
                  },
                  itemSize: 35.0,
                  glow: false,
                  initialRating: 0.0,
                  allowHalfRating: false,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.amber),
                    half: const Icon(Icons.star, color: Colors.amber),
                    empty: const Icon(Icons.star_border, color: Colors.amber),
                  ),
                ),
              ),
              16.height,
              TextField(
                controller: reviewCont,
                focusNode: reviewFocus,
                style: primaryTextStyle(),
                decoration: InputDecoration(
                  labelText: 'Write here',
                  contentPadding: const EdgeInsets.all(16),
                  labelStyle: secondaryTextStyle(),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: appColorPrimary)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: appStore.textSecondaryColor!)),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                //Normal textInputField will be displayed
                maxLines: 5,
                textInputAction: TextInputAction
                    .newline, // when user presses enter it will adapt to it
              ),
              30.height,
              FirebaseAuth.instance.currentUser != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return GestureDetector(
                            onTap: data['isAccept']
                                ? () {
                                    if (reviewCont.text != '') {
                                      toast('Review is submitted');
                                    } else {
                                      toast(errorThisFieldRequired);
                                    }
                                    getData();
                                  }
                                : null,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  color: appColorPrimary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Center(
                                child: Text("Submit",
                                    style: boldTextStyle(color: white)),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
                  : GestureDetector(
                      onTap: () {
                        const LoginPage().launch(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: appColorPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Center(
                          child: Text("Submit",
                              style: boldTextStyle(color: white)),
                        ),
                      ),
                    ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }

  addData(String id, String name, email) async {
    CollectionReference request = FirebaseFirestore.instance
        .collection('allService')
        .doc(id)
        .collection('review');
    request.add({
      'review': reviewCont.text,
      'rate': ratting,
      'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
      'name': name,
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      addData(id, value['name'], value['email']);
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .set(
      //   {'point': value['point'] + 1},
      //   SetOptions(merge: true),
      // );
    });
  }
}
