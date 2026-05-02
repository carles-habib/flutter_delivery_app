// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/controllers/order_controller.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class DeliverOption extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliverOption({
    Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
              value: value,
              activeColor: AppColors.mainColor,
              groupValue: orderController.orderType,
              onChanged: (String? value) =>
                  orderController.setDeliveryType(value!)),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            '${(value == 'take away' || isFree) ? 'free' : 'EGP${amount / 10}'}',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )
        ],
      );
    });
  }
}
