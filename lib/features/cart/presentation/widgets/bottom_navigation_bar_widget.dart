// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:delivery_app/controllers/auth_contoller.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/location_controller.dart';
import 'package:delivery_app/controllers/order_controller.dart';
import 'package:delivery_app/controllers/user_controller.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:delivery_app/features/auth/presentation/widgets/show_custom_snackbar.dart';
import 'package:delivery_app/features/cart/presentation/widgets/delivery_option.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/bottom_bar_widget.dart';
import 'package:delivery_app/models/place_order_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/add_to_cart_button.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'payment_option_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return GetBuilder<CartController>(
      builder: (controller) {
        return controller.getItems.length > 0
            ? Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                  color: Theme.of(context).bottomSheetTheme.backgroundColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //*payment option
                    GetBuilder<OrderController>(builder: (orderController) {
                      _noteController.text = orderController.foodNote;
                      return InkWell(
                        onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: Get.height * 0.9,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 520,
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width20,
                                                      right: Dimensions.width20,
                                                      top: Dimensions.height20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      PaymentOptionButton(
                                                        icon: Icons.money,
                                                        title:
                                                            'Cash on delivery',
                                                        subTitle:
                                                            'you pay after getting the delivery',
                                                        index: 0,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      // PaymentOptionButton(
                                                      //   icon: Icons.money,
                                                      //   title:
                                                      //       'Cash on delivery',
                                                      //   subTitle:
                                                      //       'safest way to pay',
                                                      //   index: 1,
                                                      // ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height20,
                                                      ),
                                                      Text(
                                                        'Delivery Option',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      DeliverOption(
                                                        value: 'delivery',
                                                        title: 'home delivery',
                                                        amount: double.parse(
                                                            Get.find<
                                                                    CartController>()
                                                                .totalAmount
                                                                .toString()),
                                                        isFree: false,
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                                .height10 /
                                                            2,
                                                      ),
                                                      DeliverOption(
                                                        value: 'take away',
                                                        title: 'take away',
                                                        amount: 10.0,
                                                        isFree: true,
                                                      ),
                                                      // SizedBox(
                                                      //   height:
                                                      //       Dimensions.height20,
                                                      // ),
                                                      // Text(
                                                      //   'Additional info',
                                                      //   style: TextStyle(
                                                      //       color: Colors.black,
                                                      //       fontSize: 20,
                                                      //       fontWeight:
                                                      //           FontWeight
                                                      //               .w800),
                                                      // ),
                                                      CustomTextField(
                                                        controller:
                                                            _noteController,
                                                        hintText: "",
                                                        icon: Icons.note,
                                                        label:
                                                            "Additional info",
                                                        maxlines: true,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            .whenComplete(() => orderController
                                .setFoodNote(_noteController.text.trim())),
                        child: Container(
                          width: double.maxFinite,
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.height20),
                            child: Center(
                              child: BigText(
                                text: 'payment option',
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.mainColor),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: Dimensions.width10 / 2,
                              ),
                              BigText(
                                text: 'EGP ' + controller.totalAmount.toString(),
                                color: Theme.of(context).canvasColor,
                              ),
                              SizedBox(
                                width: Dimensions.width10 / 2,
                              ),
                            ],
                          ),
                        ),
                        GetBuilder<OrderController>(builder: (orderController) {
                          return GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().uselLoggedIn()) {
                                var cart = Get.find<CartController>().getItems;
                                var user = Get.find<UserController>().userModel;
                                PlaceOrderBody placeOrderBody = PlaceOrderBody(
                                  cart: cart,
                                  orderAmount: 100.0,
                                  scheduleAt: '',
                                  orderNote: orderController.foodNote,
                                  address: 'aleppoo',
                                  latitude: 33.3.toString(),
                                  longitude: 33.toString(),
                                  distance: 10.0,
                                  contactPersonName: user.phone,
                                  contactPersonNumber: user.name,
                                  orderType: orderController.orderType,
                                  paymentMethod:
                                      orderController.paymentIndex == 0
                                          ? 'cash_on_delivery'
                                          : 'digital_payment',
                                );

                                Get.find<OrderController>()
                                    .placeOrder(placeOrderBody, _callBack);
                                controller.addToHistory();
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.mainColor,
                              ),
                              child: BigText(
                                text: 'Check out',
                                color: Colors.white,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              )
            : Text('');
      },
    );
  }

  void _callBack(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, 'success'));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
