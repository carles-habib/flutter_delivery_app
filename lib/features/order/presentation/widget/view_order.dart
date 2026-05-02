import 'package:delivery_app/controllers/order_controller.dart';
import 'package:delivery_app/features/auth/presentation/widgets/custom_loader.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({
    Key? key,
    required this.isCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading) {
          return CustomLoader();
        }

        List<OrderModel> orderList = isCurrent
            ? orderController.currentOrderList.reversed.toList()
            : orderController.historyOrderList.reversed.toList();

        if (orderList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                SizedBox(height: Dimensions.height20),
                Text(
                  isCurrent ? 'No Current Orders' : 'No Order History',
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return SizedBox(
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10,
              vertical: Dimensions.height15,
            ),
            child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final order = orderList[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: Dimensions.height15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Order ID ',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: Dimensions.font16,
                                    ),
                                  ),
                                  Text(
                                    '#${order.id}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(order.orderStatus),
                                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height15,
                                      ),
                                      child: Text(
                                        _getStatusText(order.orderStatus),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Dimensions.font16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  if (_showTrackButton(order.orderStatus))
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.mainColor,
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.height10,
                                          ),
                                          child: Text(
                                            'Track Order',
                                            style: TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: Dimensions.font16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          if (order.orderAmount != null) ...[
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                Text(
                                  'Amount: ',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                                Text(
                                  'EGP${order.orderAmount!.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (order.createdAt != null) ...[
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                Text(
                                  'Date: ',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                                Text(
                                  _formatDate(order.createdAt!),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  bool _showTrackButton(String? status) {
    return [
      'pending',
      'accepted',
      'confirmed',
      'processing',
      'handover',
      'picked_up'
    ].contains(status);
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'confirmed':
        return Colors.purple;
      case 'processing':
        return Colors.orange;
      case 'handover':
        return Colors.indigo;
      case 'picked_up':
        return Colors.teal;
      case 'delivered':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'accepted':
        return 'Accepted';
      case 'confirmed':
        return 'Confirmed';
      case 'processing':
        return 'Processing';
      case 'handover':
        return 'Handover';
      case 'picked_up':
        return 'Picked Up';
      case 'delivered':
        return 'Delivered';
      case 'canceled':
        return 'Canceled';
      default:
        return status ?? 'Unknown';
    }
  }

  String _formatDate(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateTime.split(' ')[0];
    }
  }
}