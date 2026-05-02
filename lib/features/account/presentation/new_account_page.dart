// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.yellowColor,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 140,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height45),
                    topRight: Radius.circular(Dimensions.height45),
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      BigText(
                        text: "Jwan Khali",
                        fontWeight: FontWeight.bold,
                        size: Dimensions.font26,
                      ),
                      BigText(text: "jwan@gmail.com"),
                      SizedBox(height: Dimensions.height30),
                      Divider(thickness: 1),
                      SizedBox(height: Dimensions.height15),
                      AccountWidget1(
                        text: 'Settings',
                        icon: Icons.settings,
                      ),
                      AccountWidget1(
                        text: 'Address',
                        icon: Icons.location_city,
                      ),
                      Divider(thickness: 1),
                      AccountWidget1(text: 'infomation', icon: Icons.info),
                      AccountWidget1(
                          text: "Log out", icon: Icons.logout_outlined)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90,
              right: 50,
              left: 50,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile.png'),
                    //  fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountWidget1 extends StatelessWidget {
  AccountWidget1({super.key, required this.text, required this.icon});
  String text;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            onTap: () {},
            backroundColor: Color(0xFFF2F2F2),
            iconColor: Colors.blueAccent,
            iconSize: Dimensions.iconSize24,
          ),
          SizedBox(width: Dimensions.width20),
          BigText(
            text: text,
            fontWeight: FontWeight.bold,
          ),
          Expanded(
            child: SizedBox(),
          ),
          AppIcon(
            icon: Icons.arrow_forward_ios,
            backroundColor: Colors.white,
            onTap: () {},
            iconSize: Dimensions.iconSize24,
          )
        ],
      ),
    );
  }
}
