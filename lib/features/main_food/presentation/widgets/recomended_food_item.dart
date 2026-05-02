// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app-columns.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon__text_widget.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedFoodItem extends StatelessWidget {
  int pageId;
  RecommendedFoodItem({
    super.key,
    required this.productsModel,
    required this.pageId,
  });
  final ProductsModel productsModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getRecommendedFood(pageId));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10, bottom: 10),
        child: Row(
          children: [
            //*image part
            Container(
              width: Dimensions.listViewImgSize,
              height: Dimensions.listViewImgSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white24,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        productsModel.img!)),
              ),
            ),
            Expanded(
              child: Container(
                height: Dimensions.pageViewTextContainer,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius15),
                    bottomRight: Radius.circular(Dimensions.radius15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width10, right: Dimensions.width10),
                  child: AppColumn(
                    text: productsModel.name!,
                    star: productsModel.stars!,
                    textStar: productsModel.stars.toString(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
