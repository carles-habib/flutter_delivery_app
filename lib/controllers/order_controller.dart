import 'dart:convert';
import 'package:delivery_app/data/repository/order_repo.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:delivery_app/models/place_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo}) {
    _currentOrderList = [];
    _historyOrderList = [];
    getOrderList();
  }

  bool _isLoading = false;
  List<OrderModel> _currentOrderList = [];
  List<OrderModel> _historyOrderList = [];

  bool get isLoading => _isLoading;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _orderType = 'delivery';
  String get orderType => _orderType;

  String _foodNote = ' ';
  String get foodNote => _foodNote;

  Future<void> placeOrder(
      PlaceOrderBody placeOrderBody, Function callBack) async {
    _isLoading = true;
    update();

    try {
      Response response = await orderRepo.placeOrder(placeOrderBody);

      if (response.statusCode == 200) {
        _isLoading = false;
        String message = response.body['message'] ?? 'Order placed successfully';
        String orderId = response.body['order_id']?.toString() ?? '-1';
        callBack(true, message, orderId);
        // Refresh order list after placing order
        await getOrderList();
      } else {
        _isLoading = false;
        callBack(false, response.statusText ?? 'Order failed', '-1');
      }
    } catch (e) {
      _isLoading = false;
      callBack(false, e.toString(), '-1');
    }

    update();
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    update();

    try {
      final String response = await rootBundle.loadString('assets/json/orders.json');
      final List<dynamic> data = json.decode(response);

      _historyOrderList = [];
      _currentOrderList = [];

      for (var orderJson in data) {
        OrderModel orderModel = OrderModel.fromJson(orderJson);

        // Use the orderStatus from your model
        String? status = orderModel.orderStatus;

        if (status != null && [
          'pending',
          'accepted',
          'processing',
          'handover',
          'picked_up'
        ].contains(status)) {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      }

      print("Current Orders: ${_currentOrderList.length}");
      print("History Orders: ${_historyOrderList.length}");

      // Debug: Print first order details
      if (_currentOrderList.isNotEmpty) {
        print("First current order ID: ${_currentOrderList[0].id}");
        print("First current order status: ${_currentOrderList[0].orderStatus}");
      }

    } catch (e) {
      print("Error loading local orders: $e");
      _historyOrderList = [];
      _currentOrderList = [];
    }

    _isLoading = false;
    update();
  }

  // Get orders by specific status
  List<OrderModel> getOrdersByStatus(String status) {
    return [..._currentOrderList, ..._historyOrderList]
        .where((order) => order.orderStatus == status)
        .toList();
  }

  // Get order by ID
  OrderModel? getOrderById(int id) {
    try {
      return [..._currentOrderList, ..._historyOrderList]
          .firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get order status color (useful for UI)
  Color getOrderStatusColor(String status) {
    switch(status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'processing':
        return Colors.purple;
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

  // Get order status display text
  String getOrderStatusText(String status) {
    switch(status) {
      case 'pending':
        return 'Pending';
      case 'accepted':
        return 'Accepted';
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

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note) {
    _foodNote = note;
    update();
  }

  // Clear all orders (useful for logout)
  void clearOrders() {
    _currentOrderList.clear();
    _historyOrderList.clear();
    update();
  }
}