// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommeded_product_controller.dart';
import 'package:delivery_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:delivery_app/features/cart/presentation/widgets/navigate_buttons.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/num_order_button.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/no_data_page_widget.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class CartPageBody extends StatelessWidget {
  const CartPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: Dimensions.width20,
          right: Dimensions.width20,
          top: Dimensions.height20 * 3,
          child: NavigateButtons(),
        ),
        GetBuilder<CartController>(builder: (cartController) {
          return cartController.getItems.length > 0
              ? Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: CartItem(),
                )
              : NoDattPage(
                  text: 'Your cart is empty',
                  image: 'assets/images/empty_cart.png',
                );
        }),
      ],
    );
  }
}
