import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderRepo {
  ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    return await apiClient.postData(
        AppConstants.PLACE_ORDER_URI, placeOrderBody.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(
      AppConstants.ORDER_LIST_URI,
    );
  }
}
