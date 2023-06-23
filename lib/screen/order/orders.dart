import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:herafy/screen/home/DTDashboardScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../products/DTPaymentScreen.dart';
import 'order_edit.dart';

class Orders extends StatelessWidget {
  final DeviceScreenType deviceScreenType;

  const Orders({Key? key, required this.deviceScreenType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff131e29),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // const DTDashboardScreen().launch;
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 640,
              width: 1180,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: FutureBuilder(
                future: getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List Orders = snapshot.data as List;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Orders",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {}),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        Orders.length,
                                        (index) => Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          child: ListTile(
                                            onTap: () {
                                              Get.defaultDialog(
                                                  backgroundColor: Colors.grey,
                                                  title: 'Contract',
                                                  content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            80.0),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'address : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index]
                                                                    ['address'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'services : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index][
                                                                    'services'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'type : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index]
                                                                    ['type'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'Information : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index]
                                                                    ['info'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'time : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index]
                                                                    ['date'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'price : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index]
                                                                    ['price'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'hours : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                Orders[index]
                                                                    ['hours'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              const Text(
                                                                'Total Price : ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                '${double.parse(Orders[index]['price']) * double.parse(Orders[index]['hours'])}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 50,
                                                          ),
                                                          StreamBuilder(
                                                              stream: FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'craftsman')
                                                                  .doc(Orders[
                                                                          index]
                                                                      [
                                                                      'craftmanID'])
                                                                  .snapshots(),
                                                              builder: (context,
                                                                  AsyncSnapshot snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return IconButton(
                                                                      onPressed:
                                                                          () {
                                                                             launchUrl(Uri.parse('https://wa.me/${snapshot.data['phone']}'));
                                                                          },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .phone));
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                          const SizedBox(
                                                            height: 100,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                            },
                                            title: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Text(
                                                    Orders[index]['services'],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                16.width,
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      // QuickAlert.show(
                                                      //   context: context,
                                                      //   type: QuickAlertType.info,
                                                      //   onCancelBtnTap: () {
                                                      //     Navigator.pop(
                                                      //         context);
                                                      //   },
                                                      //   onConfirmBtnTap: ()async {
                                                      //     await FirebaseFirestore
                                                      //         .instance
                                                      //         .collection('users')
                                                      //         .doc(FirebaseAuth
                                                      //         .instance
                                                      //         .currentUser!
                                                      //         .uid)
                                                      //         .collection('cancel')
                                                      //         .add({
                                                      //       'name': Orders[index]
                                                      //       ['services'],
                                                      //       'craftman':
                                                      //       Orders[index]
                                                      //       ['craftman'],
                                                      //       'date': DateTime.now()
                                                      //           .toString()
                                                      //     });
                                                      //     await FirebaseFirestore
                                                      //         .instance
                                                      //         .collection('users')
                                                      //         .doc(FirebaseAuth
                                                      //         .instance
                                                      //         .currentUser!
                                                      //         .uid)
                                                      //         .collection('request')
                                                      //         .doc(Orders[index]
                                                      //     ['id'])
                                                      //         .delete();
                                                      //     await FirebaseFirestore
                                                      //         .instance
                                                      //         .collection('users')
                                                      //         .doc(FirebaseAuth
                                                      //         .instance
                                                      //         .currentUser!
                                                      //         .uid)
                                                      //         .get()
                                                      //         .then((value) {
                                                      //       FirebaseFirestore
                                                      //           .instance
                                                      //           .collection('users')
                                                      //           .doc(FirebaseAuth
                                                      //           .instance
                                                      //           .currentUser!
                                                      //           .uid)
                                                      //           .set(
                                                      //           {
                                                      //             'cancel': value[
                                                      //             'cancel'] +
                                                      //                 1
                                                      //           },
                                                      //           SetOptions(
                                                      //               merge:
                                                      //               true));
                                                      //     });
                                                      //     await FirebaseFirestore
                                                      //         .instance
                                                      //         .collection(
                                                      //         'craftsman')
                                                      //         .doc(Orders[index]
                                                      //     ['craftmanID'])
                                                      //         .collection(
                                                      //         'requests')
                                                      //         .doc(Orders[index]
                                                      //     ['craftmanDocID'])
                                                      //         .set(
                                                      //         {
                                                      //           'cancelorder': true
                                                      //         },
                                                      //         SetOptions(
                                                      //             merge: true));
                                                      //     const DTDashboardScreen()
                                                      //         .launch(context);
                                                      //   },
                                                      //   showCancelBtn: true,
                                                      //   cancelBtnText: 'Cancel',
                                                      //   confirmBtnText:
                                                      //       'Confirm',
                                                      //   customAsset:
                                                      //       'images/defaultTheme/successfull.png',
                                                      //   text: '',
                                                      // );
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            // <-- SEE HERE
                                                            title:
                                                                const Text(''),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: const <
                                                                    Widget>[
                                                                  Text(
                                                                      'Are you sure want to cancel booking?'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'No'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                                onPressed:
                                                                    () async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .collection(
                                                                          'cancel')
                                                                      .add({
                                                                    'name': Orders[
                                                                            index]
                                                                        [
                                                                        'services'],
                                                                    'craftman':
                                                                        Orders[index]
                                                                            [
                                                                            'craftman'],
                                                                    'date': DateTime
                                                                            .now()
                                                                        .toString()
                                                                  });
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .collection(
                                                                          'request')
                                                                      .doc(Orders[
                                                                              index]
                                                                          [
                                                                          'id'])
                                                                      .delete();
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .get()
                                                                      .then(
                                                                          (value) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid)
                                                                        .set({
                                                                      'cancel':
                                                                          value['cancel'] +
                                                                              1
                                                                    }, SetOptions(merge: true));
                                                                  });
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'craftsman')
                                                                      .doc(Orders[
                                                                              index]
                                                                          [
                                                                          'craftmanID'])
                                                                      .collection(
                                                                          'requests')
                                                                      .doc(Orders[
                                                                              index]
                                                                          [
                                                                          'craftmanDocID'])
                                                                      .set({
                                                                    'cancelorder':
                                                                        true
                                                                  }, SetOptions(merge: true));
                                                                  const DTDashboardScreen()
                                                                      .launch(
                                                                          context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: const Text(
                                                        'Cancel order'))
                                              ],
                                            ),
                                            leading: Orders[index]['image'] ==
                                                    'null'
                                                ? const CircleAvatar(
                                                    child: Icon(Icons.person),
                                                  )
                                                : Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            Orders[index]
                                                                ['image']),
                                                      ),
                                                    ),
                                                  ),
                                            trailing: Orders[index]
                                                        ['isAccept'] ==
                                                    0
                                                ? Column(
                                                    children: [
                                                      const Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              OrdersEdit(
                                                                data: Orders[
                                                                    index],
                                                              ).launch(context);
                                                            },
                                                            child: const Text(
                                                                'Info')),
                                                      )
                                                    ],
                                                  )
                                                : Orders[index]['isAccept'] == 1
                                                    ? Column(
                                                        children: [
                                                          const Text(
                                                            'Accepted',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  OrdersEdit(
                                                                    data: Orders[
                                                                        index],
                                                                  ).launch(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Info')),
                                                          ),
                                                          Expanded(
                                                            child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'craftsman')
                                                                      .doc(Orders[
                                                                              index]
                                                                          [
                                                                          'craftmanID'])
                                                                      .collection(
                                                                          'requests')
                                                                      .doc(Orders[
                                                                              index]
                                                                          [
                                                                          'craftmanDocID'])
                                                                      .set({
                                                                    'cash': 1
                                                                  }, SetOptions(merge: true));
                                                                  const DTPaymentScreen()
                                                                      .launch(
                                                                          context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'pay')),
                                                          ),
                                                        ],
                                                      )
                                                    : Column(
                                                        children: [
                                                          const Text(
                                                            'Rejected',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      OrdersEdit(
                                                                        data: Orders[
                                                                            index],
                                                                      ).launch(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        'Info')),
                                                          )
                                                        ],
                                                      ),
                                            subtitle:
                                                Text(Orders[index]['craftman']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.feedback),
                              const SizedBox(width: 10),
                              Text(
                                "Herafy For All Services",
                                style: TextStyle(
                                    color: Theme.of(context).iconTheme.color),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }

  Future getOrders() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('request')
        .get();
    return qn.docs;
  }
}
