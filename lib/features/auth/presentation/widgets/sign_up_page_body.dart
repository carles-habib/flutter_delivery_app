// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/controllers/auth_contoller.dart';
import 'package:delivery_app/features/auth/presentation/sign_in_page.dart';
import 'package:delivery_app/features/auth/presentation/widgets/create_account_button.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_loader.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:delivery_app/features/auth/presentation/widgets/show_custom_snackbar.dart';
import 'package:delivery_app/features/auth/presentation/widgets/sign_up_with_button.dart';
import 'package:delivery_app/models/sign_up_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingUpPageBody extends StatelessWidget {
  SingUpPageBody({
    super.key,
  });

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _regestration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Type in your name ', title: 'Name');
      } else if (email.isEmpty) {
        showCustomSnackBar('Type in your email address',
            title: 'Email Address');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Type in a valid email address',
            title: 'Valid Email Address');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password ', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password can not be less than six characters',
            title: 'Password');
      } else {
        showCustomSnackBar('All went well', title: 'Perfect');
        SignUpModel signUpModel = SignUpModel(
            name: name, email: email, password: password, phone: phone);
        authController.registration(signUpModel).then((status) {
          if (status.isSuccess) {
            print('Successss');
            Get.offNamed(RouteHelper.getIntial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: true,

      body: Padding(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<AuthController>(
            builder: (authController) {
              return !authController.isLoaded
                  ? SingleChildScrollView(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimensions.height30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BigText(
                                text: 'Getting Started',
                                size: Dimensions.height20 * 1.8,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).canvasColor,
                              ),
                              SmallText(
                                text: 'Create an account to continue',
                                size: Dimensions.font26,
                                color: Theme.of(context).canvasColor,
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          CustomTextField(
                            controller: nameController,
                            icon: Icons.person,
                            hintText: 'Name',
                            label: 'Name',
                          ),
                          CustomTextField(
                            controller: emailController,
                            icon: Icons.email,
                            hintText: 'yourEmail@gmail.com',
                            label: 'Email',
                          ),
                          CustomTextField(
                            controller: passwordController,
                            icon: Icons.password_sharp,
                            hintText: 'set strong password',
                            label: 'Password',
                            obscure: true,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            icon: Icons.phone,
                            hintText: 'Phone',
                            label: 'phone',
                          ),
                          SizedBox(height: Dimensions.height30),
                          CreateAccountButton4(
                            text: 'Create Account',
                            onTap: () {
                              _regestration(authController);
                            },
                          ),
                          SizedBox(height: Dimensions.height15),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: Dimensions.font20,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          () => Get.to(() => SignInPage()),
                                    text: ' SingIn',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColor,
                                      fontSize: Dimensions.font20,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: Dimensions.height15),
                          // Center(
                          //   child: BigText(
                          //     text: 'or sign in with',
                          //     color: AppColors.paraColor,
                          //   ),
                          // ),
                          SizedBox(height: Dimensions.height15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     SingInWithButton(
                          //       icon: Icons.facebook_rounded,
                          //       text: ' Facebook',
                          //     ),
                          //     SizedBox(width: Dimensions.width20),
                          //     SingInWithButton(
                          //       icon: Icons.web,
                          //       text: ' Google',
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    )
                  : CustomLoader();
            },
          )),
    );
  }
}




// Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     BigText(
          //       text: 'Already have an account?',
          //       color: AppColors.textColor,
          //     ),
          //     BigText(
          //       text: ' SingIn',
          //       color: AppColors.mainColor,
          //     )
          //   ],
          // ),
          //  SmallText(text: 'or sign in with'),