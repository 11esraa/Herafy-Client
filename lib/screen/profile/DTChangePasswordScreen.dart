import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herafy/screen/home/DTDashboardScreen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppWidget.dart';

class DTChangePasswordScreen extends StatefulWidget {
  static String tag = '/DTChangePasswordScreen';

  const DTChangePasswordScreen({super.key});

  @override
  DTChangePasswordScreenState createState() => DTChangePasswordScreenState();
}

class DTChangePasswordScreenState extends State<DTChangePasswordScreen> {
  bool oldPassObscureText = true;
  bool newPassObscureText = true;
  bool confirmPassObscureText = true;

  var passCont = TextEditingController();
  var newPassCont = TextEditingController();
  var confirmPassCont = TextEditingController();

  var newPassFocus = FocusNode();
  var confirmPassFocus = FocusNode();

  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;

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
      appBar: appBar(context, 'Change Password'),
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
                Text('Change Password', style: boldTextStyle(size: 24)),
                30.height,
                16.height,
                TextFormField(
                  obscureText: newPassObscureText,
                  focusNode: newPassFocus,
                  controller: newPassCont,
                  style: primaryTextStyle(),
                  decoration: InputDecoration(
                    labelText: 'New Password',
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
                    suffix: Icon(!newPassObscureText
                            ? Icons.visibility
                            : Icons.visibility_off)
                        .onTap(() {
                      newPassObscureText = !newPassObscureText;
                      setState(() {});
                    }),
                  ),
                  onFieldSubmitted: (s) =>
                      FocusScope.of(context).requestFocus(confirmPassFocus),
                  validator: (s) {
                    if (s!.trim().isEmpty) {
                      return 'Password is Less than 8 character';
                    }
                    return null;
                  },
                ),
                16.height,
                TextFormField(
                  obscureText: confirmPassObscureText,
                  focusNode: confirmPassFocus,
                  controller: confirmPassCont,
                  style: primaryTextStyle(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                    suffix: Icon(!confirmPassObscureText
                            ? Icons.visibility
                            : Icons.visibility_off)
                        .onTap(() {
                      confirmPassObscureText = !confirmPassObscureText;
                      setState(() {});
                    }),
                  ),
                  validator: (s) {
                    if (s!.trim().isEmpty) return errorThisFieldRequired;
                    if (s.trim() != newPassCont.text) {
                      return 'password does not match';
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
                  child: Text('Submit',
                      style: boldTextStyle(color: white, size: 18)),
                ).onTap(() async {
                  if (formKey.currentState!.validate()) {
                    // formKey.currentState!.save();
                    print(newPassCont.text);
                    await FirebaseAuth.instance.currentUser!
                        .updatePassword(newPassCont.text);
                    const DTDashboardScreen().launch(context);
                  } else {
                    autoValidate = true;
                  }
                  setState(() {});
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}