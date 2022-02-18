import 'package:flutter/material.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h*0.5,
      width: w*0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow:  const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 12.0,
            offset: Offset(10.0, 14.0),
          ),
        ]
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: h* 0.05),
                const Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
                buildTimer(),
                const OtpForm(),
                SizedBox(height: h* 0.1),
                GestureDetector(
                  onTap: () {
                    // OTP code resend
                  },
                  child: const Text(
                    "Resend OTP Code",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: const TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}