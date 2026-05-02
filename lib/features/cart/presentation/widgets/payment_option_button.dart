
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/controllers/order_controller.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'package:delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final int index;
  const PaymentOptionButton({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: () => orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)
              ]),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            trailing: _selected
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.mainColor,
                  )
                : null,
          ),
        ),
      );
    });
  }
}
