// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/controllers/auth_contoller.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/user_controller.dart';
import 'package:delivery_app/features/account/presentation/widgets/information.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_loader.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().uselLoggedIn();

    // Fetch data only if logged in and not already loaded
    if (_userLoggedIn) {
      var userController = Get.find<UserController>();
      if (!userController.isLoaded) {
        userController.getUserData();
      }
    }

    return Scaffold(
        body: GetBuilder<UserController>(builder: (userController) {
          if (!_userLoggedIn) {
            // Sign-in prompt for logged-out users
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logoo.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.signInPage),
                    child: Container(
                      height: Dimensions.height20 * 5,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(
                          text: 'Sign In',
                          color: Colors.white,
                          size: Dimensions.font26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // Show loader while fetching JSON data
          if (!userController.isLoaded) {
            return CustomLoader();
          }

          // Profile UI for logged-in users
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20 * 10,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/back2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.height30 * 5,
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
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height20 * 4),
                    child: Column(
                      children: [
                        BigText(
                          text: userController.userModel.name,
                          fontWeight: FontWeight.bold,
                          size: Dimensions.font26,
                          color: Theme.of(context).canvasColor,
                        ),
                        BigText(
                          text: userController.userModel.email,
                          color: Theme.of(context).canvasColor,
                        ),
                        SizedBox(height: Dimensions.height30),
                        Divider(thickness: 1),
                        SizedBox(height: Dimensions.height15),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.getSettingsPage()),
                          child: AccountWidget1(
                            text: 'Settings',
                            icon: Icons.settings,
                          ),
                        ),
                        Divider(thickness: 1),
                        GestureDetector(
                          onTap: () => Get.to(() => InformationScreen()),
                          child: AccountWidget1(text: 'Information', icon: Icons.info),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: AccountWidget1(
                            text: "Log out",
                            icon: Icons.logout_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Dimensions.height30 * 3,
                right: 50,
                left: 50,
                child: Container(
                  height: Dimensions.height45 * 3,
                  width: Dimensions.height45 * 3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );
  }
}

class AccountWidget1 extends StatelessWidget {
  final String text;
  final IconData icon;
  const AccountWidget1({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            onTap: () {},
            backroundColor: Theme.of(context).cardColor,
            iconColor: Colors.blueAccent,
            iconSize: Dimensions.iconSize24,
          ),
          SizedBox(width: Dimensions.width20),
          BigText(
            text: text,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
          Expanded(child: SizedBox()),
          AppIcon(
            icon: Icons.arrow_forward_ios,
            backroundColor: Theme.of(context).cardColor,
            onTap: () {},
            iconSize: Dimensions.iconSize24,
          )
        ],
      ),
    );
  }
}