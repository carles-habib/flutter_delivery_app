import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NoDattPage extends StatelessWidget {
  const NoDattPage(
      {super.key,
      required this.text,
      this.image = 'assets/images/emptu_cart.png'});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: MediaQuery.of(context).size.height * 0.0175),
        ),
      ],
    );
  }
}
