import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class NavigateButtons extends StatelessWidget {
  const NavigateButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIcon(
          icon: Icons.arrow_back_ios,
          onTap: () {
            Get.back();
          },
          iconColor: Colors.white,
          backroundColor: AppColors.mainColor,
          iconSize: Dimensions.iconSize24,
        ),
        SizedBox(
          width: Dimensions.width20 * 5,
        ),
        AppIcon(
          icon: Icons.home_outlined,
          onTap: () {
            Get.toNamed(RouteHelper.getIntial());
          },
          iconColor: Colors.white,
          backroundColor: AppColors.mainColor,
          iconSize: Dimensions.iconSize24,
        ),
        AppIcon(
          icon: Icons.shopping_cart_checkout,
          onTap: () {},
          iconColor: Colors.white,
          backroundColor: AppColors.mainColor,
          iconSize: Dimensions.iconSize24,
        )
      ],
    );
  }
}
