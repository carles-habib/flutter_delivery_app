// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/services/theme_service.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app-columns.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageItem extends StatelessWidget {
  const FoodPageItem({
    super.key,
    required this.currentPageValue,
    required this.index,
    required this.popularProduct,
  });
  final ProductsModel popularProduct;
  final double currentPageValue;
  final int index;

  @override
  Widget build(BuildContext context) {
    double _scaleFactor = 0.8;
    double _height = Dimensions.pageViewContainer;
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale), 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).splashColor,
                    // Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: //10,
                        Dimensions.height10,
                    right: 15,
                    left: 15),
                child: AppColumn(
                  text: popularProduct.name!,
                  star: popularProduct.stars!,
                  textStar: popularProduct.stars.toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
