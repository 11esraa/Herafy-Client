import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/AppConstant.dart';
import '../home/DTDashboardScreen.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit(
      {super.key,
      required this.phone,
      required this.name,
      required this.image,
      required this.gender});

  final String name;
  final String phone;
  final String image;
  final String gender;

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool showPassword = false;

  String selctFile = '';

  XFile? file;

  Uint8List? selectedImageInBytes;

  List<Uint8List> pickedImagesInBytes = [];

  int imageCounts = 0;

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();
  bool isMale = false;
  bool isFemale = false;
  String? gender;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    gender = widget.gender;
    phone = TextEditingController(text: widget.phone);
    name = TextEditingController(text: widget.name);
    widget.gender == 'male' ? isMale = true : isFemale = true;
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
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      selctFile.isEmpty
                          ? widget.image == 'null'
                              ? Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: isMale
                                              ? const AssetImage(profileImage)
                                              : const AssetImage(
                                                  'assets/images/img.png'))),
                                )
                              : Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            widget.image,
                                          ))),
                                )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.memory(
                                selectedImageInBytes!,
                                width: 150,
                                height: 150,
                              ),
                            ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )).onTap(() {
                        selectFile(true);
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextFormField(
                    controller: name,
                    obscureText: false,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Invalid Data';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: false
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
                        labelText: "Full Name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: widget.name,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextFormField(
                    controller: phone,
                    obscureText: false,
                    validator: (val) {
                      if (!val!.startsWith("078") &&
                              !val.startsWith("077") &&
                              !val.startsWith("079") ||
                          val.length > 10 ||
                          val.length < 10) {
                        return 'Invalid Data';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: false
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
                        labelText: "phone",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: widget.phone,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 50,
                          child: Text(
                            "Gender",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isMale = true;
                              isFemale = false;
                              gender = 'male';
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue[50],
                            child: Icon(Icons.face,
                                color:
                                    isMale ? Colors.greenAccent : Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        const SizedBox(
                          width: 50.0,
                          child: Text(
                            "Male",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFemale = true;
                              isMale = false;
                              gender = 'female';
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue[50],
                            child: Icon(
                              Icons.face,
                              color:
                                  isFemale ? Colors.greenAccent : Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        const SizedBox(
                          width: 100.0,
                          child: Text(
                            "Female",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    );
                  },
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          uploadFile().then((value) {
                            const DTDashboardScreen().launch(context);
                          });
                        }
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

  Future getData() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });

      fileResult.files.forEach((element) {
        setState(() {
          pickedImagesInBytes.add(element.bytes!);

          imageCounts += 1;
        });
      });
    }
    print(selctFile);
  }

  Future uploadFile() async {
    if (selctFile.isNotEmpty) {
      String imageUrl = '';
      try {
        firabase_storage.UploadTask uploadTask;

        firabase_storage.Reference ref = firabase_storage
            .FirebaseStorage.instance
            .ref()
            .child('users')
            .child('/$selctFile');
        final metadata =
            firabase_storage.SettableMetadata(contentType: 'image/jpeg');

        // uploadTask = ref.putFile(File(file!.path));
        uploadTask = ref.putData(selectedImageInBytes!, metadata);

        await uploadTask.whenComplete(() => null);
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
        print(FirebaseAuth.instance.currentUser!.uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'image': imageUrl,
          "name": name.text,
          "gender": gender,
          "phone": phone.text,
        }, SetOptions(merge: true));
      } catch (e) {
        print(e);
      }
      return imageUrl;
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'image': widget.image,
        "name": name.text,
        "gender": gender,
        "phone": phone.text,
      }, SetOptions(merge: true));
    }
  }

  Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      TextEditingController controller,
      Function() validate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        validator: validate(),
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
