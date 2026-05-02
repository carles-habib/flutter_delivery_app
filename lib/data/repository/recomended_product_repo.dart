import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class RecomendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecomendedProductRepo({required this.apiClient});

  Future<Response> getRecomendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMANDED_PRODUCT_URI);
  }
}
