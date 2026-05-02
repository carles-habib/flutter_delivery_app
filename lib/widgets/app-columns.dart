// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icon__text_widget.dart';
import 'package:delivery_app/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  const AppColumn({
    Key? key,
    required this.text,
    required this.star,
    required this.textStar,
  }) : super(key: key);
  final String text;
  final int star;
  final String textStar;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: text,
            size: Dimensions.font26,
            color: Theme.of(context).canvasColor,
          ),
          SizedBox(height: Dimensions.height10),
          Row(
            children: [
              Wrap(
                children: List.generate(
                  star,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimensions.width15,
                  ),
                ),
              ),
              SizedBox(width: Dimensions.width10),
              SmallText(text: textStar),
              SizedBox(width: Dimensions.width10),
              SmallText(text: ''),
              SizedBox(width: Dimensions.width10),
              Expanded(child: SmallText(text: 'comment ')),
            ],
          ),
          SizedBox(height: Dimensions.height15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconTextWidget(
                  icon: Icons.circle_sharp,
                  text: 'Normal',
                  iconColor: AppColors.iconColor1),
              IconTextWidget(
                  icon: Icons.location_on,
                  text: '1.5km',
                  iconColor: AppColors.mainColor),
              IconTextWidget(
                  icon: Icons.access_time_rounded,
                  text: '32min',
                  iconColor: AppColors.icontColor2),
            ],
          )
        ],
      ),
    );
  }
}
