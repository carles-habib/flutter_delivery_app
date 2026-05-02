// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/models/cart_model.dart';
import 'package:delivery_app/routes/routes_helper.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/no_data_page_widget.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCarthistoryList1().reversed.toList();
    Map<String, int> cartItemPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderList() {
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderList();
    int listCounter = 0;

    Widget timeWidget(int index) {
      var outputData = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time.toString());
        var inputDate = DateTime.parse(dateTime.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputData = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputData.toString(),
        color: Theme.of(context).canvasColor,
      );
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          title: BigText(
            text: 'Cart History',
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppIcon(
                icon: Icons.shopping_cart_outlined,
                onTap: () {},
                backroundColor: Colors.transparent,
                iconColor: Colors.white,
                iconSize: Dimensions.iconSize24,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            GetBuilder<CartController>(builder: (cartController) {
              return cartController.getCarthistoryList1().length > 0
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPerOrder.length; i++)
                                Container(
                                  height: Dimensions.height30 * 4,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              itemsPerOrder[i],
                                              (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                    .width10 /
                                                                2),
                                                        height: Dimensions
                                                                .height20 *
                                                            4,
                                                        width: Dimensions
                                                                .height20 *
                                                            4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!),
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: Dimensions.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: 'Total',
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                ),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      ' items',
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print('tapped');
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))),
                                                        );
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
                                                    child: SmallText(
                                                      text: 'one more',
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: Get.height / 1.5,
                      child: NoDattPage(
                        text: 'You did\'nt buy anything so far',
                        image: 'assets/images/empty_box.png',
                      ),
                    );
            })
          ],
        ));
  }
}
