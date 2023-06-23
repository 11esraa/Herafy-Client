import 'package:flutter/material.dart';

import 'component/body.dart';
import 'component/menu.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          MediaQuery.of(context).size.width >= 980
              ? Menu()
              : const SizedBox(), // Responsive
          const Body()
        ],
      ),
    );
  }
}
