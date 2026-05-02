
import 'package:delivery_app/controllers/auth_contoller.dart';
import 'package:delivery_app/controllers/order_controller.dart';
import 'package:delivery_app/features/order/presentation/widget/view_order.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().uselLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    } else {
      _tabController = TabController(length: 0, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.yellowColor,
              indicatorWeight: 3,
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'current',
                ),
                Tab(
                  text: 'History',
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
