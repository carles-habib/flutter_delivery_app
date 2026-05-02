// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/data/api/api_client.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({
    required this.apiClient,
  });
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}
