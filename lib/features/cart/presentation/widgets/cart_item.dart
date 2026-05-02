import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommeded_product_controller.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/num_order_button.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height15),
      //  color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GetBuilder<CartController>(
          builder: (cartController) {
            var _cartList = cartController.getItems;

            return ListView.builder(
              itemCount: _cartList.length,
              itemBuilder: (_, index) {
                return Container(
                  height: Dimensions.height20 * 5,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          var popularIndex =
                              Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                          if (popularIndex >= 0) {
                            Get.toNamed(RouteHelper.getPopularFood(
                                popularIndex, 'cartpage'));
                          } else {
                            var recommendedIndex =
                                Get.find<RecommendedProductController>()
                                    .recommendedProductList
                                    .indexOf(_cartList[index].product!);
                            if (recommendedIndex < 0) {
                              Get.snackbar('History Product',
                                  'product review is not avalibale for history product',
                                  backgroundColor: AppColors.mainColor,
                                  colorText: Colors.white);
                            } else {
                              Get.toNamed(RouteHelper.getRecommendedFood(
                                  recommendedIndex));
                            }
                          }
                        },
                        child: Container(
                          width: Dimensions.height20 * 5,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                                image: AssetImage(
                                    cartController.getItems[index].img!),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width15,
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.height20 * 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BigText(
                                text: cartController.getItems[index].name!,
                                color: Theme.of(context).canvasColor,
                              ),
                              SmallText(text: 'comment'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(
                                    text: cartController.getItems[index].price!
                                        .toString(),
                                    color: Colors.redAccent,
                                  ),
                                  NumOrderButton(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10,
                                    add: () {
                                      cartController.addItem(
                                          _cartList[index].product!, 1);
                                    },
                                    remove: () {
                                      cartController.addItem(
                                          _cartList[index].product!, -1);
                                    },
                                    text: _cartList[index].quantity.toString(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
