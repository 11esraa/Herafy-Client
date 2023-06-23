import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herafy/screen/login/login.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppWidget.dart';

class ForgetPassword extends StatefulWidget {
  static String tag = '/ForgetPassword';

  const ForgetPassword({super.key});

  @override
  ForgetPasswordState createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  bool oldPassObscureText = true;
  bool newPassObscureText = true;
  bool confirmPassObscureText = true;

  var email = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Forget Password'),
      body: Center(
        child: Container(
          width: dynamicWidth(context),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Enter Your Email', style: boldTextStyle(size: 24)),
                30.height,
                TextFormField(
                  controller: email,
                  style: primaryTextStyle(),
                  decoration: InputDecoration(
                    labelText: 'Your Email',
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
                  validator: (s) {
                    if (s!.trim().isEmpty) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                16.height,
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      color: appColorPrimary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: defaultBoxShadow()),
                  child: Text('Send',
                      style: boldTextStyle(color: white, size: 18)),
                ).onTap(() async {
                  resetPassword(email.text).then((value) {
                    const LoginPage().launch(context);
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
