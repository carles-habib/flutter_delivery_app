// ignore_for_file: sort_child_properties_last

import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.backroundColor,
      this.iconColor = Colors.white});
  final IconData icon;
  final String text;
  final Color backroundColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height20,
          bottom: Dimensions.height10),
      child: Container(
        padding: EdgeInsets.only(
            //left: Dimensions.width20,
            top: Dimensions.height10,
            bottom: Dimensions.height10),
        child: ListTile(
          leading: AppIcon(
            icon: icon,
            onTap: () {},
            backroundColor: backroundColor,
            iconColor: iconColor,
            size: Dimensions.height10 * 5,
            iconSize: Dimensions.height10 * 5 / 2,
          ),
          title: BigText(text: text),
        ),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 2),
              color: Colors.grey.withOpacity(0.2))
        ]),
      ),
    );
  }
}
