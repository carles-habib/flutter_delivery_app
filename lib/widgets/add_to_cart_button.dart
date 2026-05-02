import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final int price;
  final String text;
  const AddToCartButton({
    super.key,
    required this.price,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.height20,
        bottom: Dimensions.height20,
        left: Dimensions.width20,
        right: Dimensions.width20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.mainColor,
      ),
      child: BigText(
        text: 'EGP$price | $text',
        color: Colors.white,
      ),
    );
  }
}
