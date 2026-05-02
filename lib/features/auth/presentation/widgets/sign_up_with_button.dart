import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class SingInWithButton extends StatelessWidget {
  const SingInWithButton({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height10,
        horizontal: Dimensions.width15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        border: Border.all(
          width: 1.5,
          color: AppColors.mainColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          BigText(
            text: text,
            color: Theme.of(context).canvasColor,
          )
        ],
      ),
    );
  }
}
