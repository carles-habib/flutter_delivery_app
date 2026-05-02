// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommeded_product_controller.dart';
import 'package:delivery_app/features/cart/presentation/cart_screen.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/bottom_bar_widget.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/expandable_text_widget.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/favorite_button.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/add_to_cart_button.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecomendedFoodDetailsScreen extends StatelessWidget {
  RecomendedFoodDetailsScreen({super.key, required this.pageId});
  int pageId;
  @override
  Widget build(BuildContext context) {
    ProductsModel product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.clear,
                  onTap: () {
                    Get.back();
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
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 18,
                                iconColor: Colors.transparent,
                                backroundColor: AppColors.mainColor,
                                onTap: () {
                                  Get.toNamed(RouteHelper.getCartPage());
                                },
                              ),
                            )
                          : Container(),
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 3,
                              top: 3,
                              child: BigText(
                                text: controller.totalItems.toString(),
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimensions.font26,
                  color: Theme.of(context).canvasColor,
                )),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: Dimensions.height10 / 2, bottom: Dimensions.height10),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
               product.img!,
              width: double.maxFinite,
              fit: BoxFit.cover,
            )

                ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: ExpandableTextWidget(text: product.description!),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppIcon(
                      icon: Icons.remove,
                      backroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                      onTap: () {
                        controller.setQuantity(false);
                      },
                    ),
                    BigText(
                      text: 'EGP ${product.price} ' +
                          ' X ' +
                          controller.inCartItem.toString(),
                      color: Theme.of(context).canvasColor,
                      size: Dimensions.font26,
                    ),
                    AppIcon(
                      icon: Icons.add,
                      backroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                      onTap: () {
                        controller.setQuantity(true);
                      },
                    ),
                  ],
                ),
              ),
              BottomBarWidget(
                widget1: Container(),
                widget2: GestureDetector(
                  onTap: () {
                    controller.addItem(product);
                  },
                  child: AddToCartButton(
                    price: product.price!,
                    text: 'Add to cart',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
