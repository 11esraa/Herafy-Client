import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/AppWidget.dart';
import '../home/DTDashboardScreen.dart';



class DTPaymentProcessScreen extends StatefulWidget {
  final bool? isSuccessFul;

  const DTPaymentProcessScreen({super.key, this.isSuccessFul});

  @override
  _DTPaymentProcessScreenState createState() => _DTPaymentProcessScreenState();
}

class _DTPaymentProcessScreenState extends State<DTPaymentProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, ''),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.isSuccessFul!
                  ? 'images/defaultTheme/successfull.png'
                  : 'images/defaultTheme/cancel.png',
              height: 100,
              width: 100,
            ),
            8.height,
            Text(
              widget.isSuccessFul! ? 'Order Successful' : 'Order Failed',
              style: boldTextStyle(
                  color: widget.isSuccessFul! ? greenColor : redColor),
            ),
            ElevatedButton(
                onPressed: () {
                  const DTDashboardScreen().launch(context);
                },
                child: const Text('Choose anther Services'))
          ],
        ),
      ),
    );
  }
}
