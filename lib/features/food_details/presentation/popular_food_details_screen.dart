import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/features/food_details/presentation/widgets/food_details_widget.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetailsScreen extends StatelessWidget {
  final int pageId;
  final String page;
  PopularFoodDetailsScreen(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    ProductsModel product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return FoodDetailsWidget(
      pageId: pageId,
      page: page,
    );
  }
}
