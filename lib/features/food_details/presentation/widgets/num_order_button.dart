import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumOrderButton extends StatelessWidget {
  const NumOrderButton({
    super.key,
    required this.top,
    required this.bottom,
    required this.right,
    required this.left,
    required this.add,
    required this.remove,
    required this.text,
  });
  final double top;
  final double bottom;
  final double right;
  final VoidCallback add;
  final VoidCallback remove;
  final String text;

  final double left;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(builder: (popularProduct) {
      return Container(
        padding: EdgeInsets.only(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                remove();
                // popularProduct.setQuantity(false);
              },
              child: Icon(
                Icons.remove,
                color: AppColors.singColor,
              ),
            ),
            SizedBox(
              width: Dimensions.width10 / 2,
            ),
            BigText(
              text: text,
              color: Theme.of(context).canvasColor,
            ),
            SizedBox(
              width: Dimensions.width10 / 2,
            ),
            GestureDetector(
              onTap: () {
                add();
                // popularProduct.setQuantity(true);
              },
              child: Icon(
                Icons.add,
                color: AppColors.singColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
