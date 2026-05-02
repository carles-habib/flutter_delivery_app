import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class CreateAccountButton4 extends StatelessWidget {
  const CreateAccountButton4({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.height20),
        // height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(Dimensions.height45),
        ),
        child: Center(
          child: BigText(
            text: text,
            color: Colors.white,
            size: Dimensions.font26,
          ),
        ),
      ),
    );
  }
}
