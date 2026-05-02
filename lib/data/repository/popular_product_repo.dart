import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
