import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/AppWidget.dart';
import '../drawer/DTDrawerWidget.dart';


class DTContactUsScreen extends StatefulWidget {
  static String tag = '/DTContactUsScreen';

  const DTContactUsScreen({super.key});

  @override
  DTContactUsScreenState createState() => DTContactUsScreenState();
}

class DTContactUsScreenState extends State<DTContactUsScreen> {
  var searchCont = TextEditingController();

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
    return Observer(
      builder: (_) => Scaffold(
        appBar: appBar(context, 'Contact Us'),
        drawer: const DTDrawerWidget(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('images/logo.png'),
                width: 200,
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.phone),
                  ),
                  10.width,
                  const Text(
                    'Phone',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  10.width,
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '+962776359812',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.email),
                  ),
                  10.width,
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  10.width,
                   Column(
                    children: [
                      Text(
                        'HerafyInfo@herafy.com',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.location_on_rounded),
                  ),
                  10.width,
                  const Text(
                    'Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  10.width,
                   Column(
                    children: [
                      Text(
                        'Mecca street, Bldg N: 24, 3rd floor. Amman Jordan',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
