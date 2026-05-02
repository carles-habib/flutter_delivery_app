// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/controllers/auth_contoller.dart';
import 'package:delivery_app/features/auth/presentation/sign_in_page.dart';
import 'package:delivery_app/features/auth/presentation/sign_up_page.dart';
import 'package:delivery_app/features/auth/presentation/widgets/create_account_button.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_loader.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:delivery_app/features/auth/presentation/widgets/show_custom_snackbar.dart';
import 'package:delivery_app/features/auth/presentation/widgets/sign_up_with_button.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingInPageBody extends StatelessWidget {
  SingInPageBody({
    super.key,
  });

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  void _login(AuthController authController) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String phone = phoneController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar('Type in your email address', title: 'Email Address');
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

      authController.login(email, password, phone).then((status) {
        if (status.isSuccess) {
          print('yessssss0');
          Get.toNamed(RouteHelper.getIntial());
        } else {
          showCustomSnackBar("ee ${status.message}");
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<AuthController>(
            builder: (authController) {
              return !authController.isLoaded
                  ? ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.height45),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BigText(
                                  text: 'Welcome Back',
                                  size: Dimensions.height20 * 1.8,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).canvasColor,

                                ),
                                SmallText(
                                  text: 'Sign in your account',
                                  size: Dimensions.font26,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height20),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: [
                                    Checkbox(
                                      value: false,
                                      onChanged: (_) {},
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height15),
                                      child: BigText(
                                        text: 'Remeber',
                                        color: AppColors.singColor,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _login(authController);
                                  },
                                  child: BigText(
                                    text: 'Forgot Password?',
                                    color: AppColors.singColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Dimensions.height30 * 2),
                            CreateAccountButton4(
                              onTap: () {
                                _login(authController);
                              },
                              text: 'Log In',
                            ),
                            SizedBox(height: Dimensions.height15),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Don\'t  have an account?',
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: Dimensions.font20,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Get.to(
                                            () => SignUpPage(),
                                            transition: Transition.fade),
                                      text: ' Sing Up',
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
                            SizedBox(height: Dimensions.height30),
                            Center(
                              child: BigText(
                                text: 'or sign in with',
                                color: AppColors.paraColor,
                              ),
                            ),
                            SizedBox(height: Dimensions.height15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingInWithButton(
                                  icon: Icons.mail,
                                  text: ' Gmail',
                                ),
                                SizedBox(width: Dimensions.width20),
                                SingInWithButton(
                                  icon: Icons.facebook_outlined,
                                  text: ' Facebook',
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  : CustomLoader();
            },
          )),
    );
  }
}