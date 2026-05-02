// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  OrderSuccessPage({
    Key? key,
    required this.orderID,
    required this.status,
  }) : super(key: key);
  final String orderID;
  final int status;
  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {});
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.mainColor,
                size: Dimensions.height10 * 9,
              ),
              // Image.asset(
              //   status == 1
              //       ? 'assets/images/back.png'
              //       : 'assets/images/back2.png',
              //   width: 100,
              //   height: 100,
              // ),
              SizedBox(
                height: Dimensions.height45,
              ),
              Text(
                status == 1
                    ? 'You placed order sucessfuly'
                    : "your order failed",
                style: TextStyle(
                    color: AppColors.mainColor, fontSize: Dimensions.font20),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.height20,
                  vertical: Dimensions.height20,
                ),
                child: Text(
                  status == 1 ? 'Successful Order' : 'Failed Order',
                  style: TextStyle(
                      color: AppColors.mainColor, fontSize: Dimensions.font20),
                ),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              GestureDetector(
                  onTap: () {
                    Get.offAllNamed(RouteHelper.getIntial());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'go back',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font20),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
