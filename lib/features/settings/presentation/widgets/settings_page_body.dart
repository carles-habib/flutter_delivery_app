// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/services/theme_service.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPageBody extends StatelessWidget {
  const SettingPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(
                      text: Get.isDarkMode ? 'Dark' : "light",
                      color: Theme.of(context).canvasColor,
                    ),
                    AppIcon(
                        icon: Get.isDarkMode
                            ? Icons.dark_mode_sharp
                            : Icons.light_mode,
                        onTap: () {
                          ThemeSevice().changeTheme();
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
