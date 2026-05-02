// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/data/repository/cart_repo.dart';
import 'package:delivery_app/features/cart/presentation/cart_screen.dart';
import 'package:delivery_app/features/main_food/presentation/main_food_page.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/widgets/add_to_cart_button.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/bottom_bar_widget.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/expandable_text_widget.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/num_order_button.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app-columns.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon__text_widget.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class FoodDetailsWidget extends StatelessWidget {
  FoodDetailsWidget({super.key, required this.pageId, required this.page});
  int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    //*controller
    ProductsModel product =
        Get.find<PopularProductController>().popularProductList[pageId];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                       product.img!),
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  onTap: () {
                    if (page == 'cartpage') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getIntial());
                    }
                  },
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        onTap: () {
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                      ),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 18,
                                iconColor: Colors.transparent,
                                backroundColor: AppColors.mainColor,
                                onTap: () {},
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 3,
                              top: 3,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                color: Colors.white,
                                size: 14,
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    star: product.stars!,
                    text: product.name!,
                    textStar: product.stars.toString(),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(
                    text: 'Introduce',
                    color: Theme.of(context).canvasColor,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: product.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return BottomBarWidget(
            widget1: NumOrderButton(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20,
              add: () {
                controller.setQuantity(true);
              },
              remove: () {
                controller.setQuantity(false);
              },
              text: controller.inCartItem.toString(),
            ),
            widget2: GestureDetector(
              onTap: () {
                controller.addItem(product);
              },
              child: AddToCartButton(
                price: product.price!,
                text: 'Add to cart',
              ),
            ),
          );
        },
      ),
    );
  }
}
