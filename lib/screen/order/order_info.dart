import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../products/DTPaymentProcessScreen.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
    super.key,
    required this.productModel,
  });

  final productModel;

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  TextEditingController address = TextEditingController();

  TextEditingController info = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController hours = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  bool showPassword = true;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "More Info",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : '$_selectedDate',
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _pickDate,
                      child: const Text('Pick a date'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedTime == null
                          ? 'No time selected'
                          : ' ${_selectedTime.format(context)}',
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _pickTime,
                      child: const Text('Pick a time'),
                    ),
                  ],
                ),
                buildTextField("Address", '', false, address),
                buildTextField("phone", '', false, phone),
                buildTextField("Hours", '', false, hours),
                buildTextField("Info", '', false, info),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          String id = FirebaseFirestore.instance
                              .collection('craftsman')
                              .doc(widget.productModel['uid'])
                              .collection('requests')
                              .doc()
                              .id;
                          String id1 = FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('request')
                              .doc()
                              .id;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('request')
                              .doc(id1)
                              .set({
                            'id': id1,
                            'isAccept': 0,
                            'craftmanDocID': id,
                            'craftmanID': widget.productModel['uid'],
                            'services': widget.productModel['name'],
                            'image': widget.productModel['image'],
                            'type': widget.productModel['type'],
                            'date': _selectedDate.toString(),
                            'craftman': widget.productModel['craftsman'],
                            'time': _selectedTime.toString(),
                            'info': info.text,
                            'phone': phone.text,
                            'address': address.text,
                            'cancelorder': false,
                            'hours': hours.text,
                            'price': widget.productModel['price']
                          });

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((value) async {
                            await FirebaseFirestore.instance
                                .collection('craftsman')
                                .doc(widget.productModel['uid'])
                                .collection('requests')
                                .doc(id)
                                .set({
                              'id': id,
                              'userDocID': id1,
                              'user': value['name'],
                              'userImage': value['image'],
                              'userUid': value['id'],
                              'phone': value['phone'],
                              'isAccept': 0,
                              'cash': 0,
                              'craftman': widget.productModel['craftsman'],
                              'services': widget.productModel['name'],
                              'image': widget.productModel['image'],
                              'type': widget.productModel['type'],
                              'date': _selectedDate.toString(),
                              'time': _selectedTime.toString(),
                              'info': info.text,
                              'cancelorder': false,
                              'address': address.text,
                              'phone': phone.text,
                              'hours': hours.text,
                              'price': widget.productModel['price']
                            });
                          });
                          getData();

                          const DTPaymentProcessScreen(
                            isSuccessFul: true,
                          ).launch(context);
                        }
                      },
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {'point': value['point'] + 1},
        SetOptions(merge: true),
      );
    });
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter valid data';
          }
          return null;
        },
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
