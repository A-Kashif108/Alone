import 'package:mdg_project/components/body.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue[100],
      child:  const Center(
          child: Body(),
      ),
    );
  }
}
