import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../home/DTDashboardScreen.dart';

class OrdersEdit extends StatefulWidget {
  const OrdersEdit({super.key, required this.data});

  final data;

  @override
  State<OrdersEdit> createState() => _OrdersEditState();
}

class _OrdersEditState extends State<OrdersEdit> {
  bool showPassword = false;

  TextEditingController name = TextEditingController();

  TextEditingController address = TextEditingController();
  TextEditingController info = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  late DateTime _selectedDate = DateTime.now();
  late TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        date = TextEditingController(text: pickedDate.toString());
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
        time = TextEditingController(text: pickedTime.toString());
      });
    }
  }

  @override
  void initState() {
    address = TextEditingController(text: widget.data['address']);
    info = TextEditingController(text: widget.data['info']);
    date = TextEditingController(text: widget.data['date']);
    time = TextEditingController(text: widget.data['time']);
    name = TextEditingController(text: widget.data['services']);
    super.initState();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Order Info",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        // buildTextField("Name", '', false, name),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: buildTextField("date", '', false, date)),
                        //     const SizedBox(width: 16),
                        //     ElevatedButton(
                        //       onPressed: _pickDate,
                        //       child: const Text('Pick a date'),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: buildTextField("time", '', false, time)),
                        //     const SizedBox(width: 16),
                        //     ElevatedButton(
                        //       onPressed: _pickTime,
                        //       child: const Text('Pick a time'),
                        //     ),
                        //   ],
                        // ),
                        // buildTextField("info", info.text, false, info),
                        buildTextField("address", address.text, false, address),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('request')
                            .doc(widget.data['id'])
                            .set({
                          // 'time': time.text,
                          // 'info': info.text,
                          // 'date': date.text,
                          'address': address.text
                        }, SetOptions(merge: true)).then((value) {
                          const DTDashboardScreen().launch(context);
                        });
                        await FirebaseFirestore.instance
                            .collection('craftsman')
                            .doc(widget.data['craftmanID'])
                            .collection('requests')
                            .doc(widget.data['craftmanDocID'])
                            .set({'address': address.text},
                                SetOptions(merge: true));
                      },
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "SAVE",
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

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller,
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
