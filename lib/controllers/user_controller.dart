// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/data/repository/user_repo.dart';
import 'package:delivery_app/models/response_model.dart';
import 'package:delivery_app/models/sign_up_model.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:delivery_app/data/repository/auth_repo.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoaded = false;
  late UserModel _userModel;
  bool get isLoaded => _isLoaded;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserData() async {
    _isLoaded = false;
    update();

    try {
      final String response = await rootBundle.loadString('assets/json/user_data.json');

      final data = await json.decode(response);

      _userModel = UserModel.fromJson(data);

      _isLoaded = true;
      update();
      return ResponseModel(true, 'Successfully loaded local data');
    } catch (e) {
      print("Error loading local JSON: $e");
      return ResponseModel(false, e.toString());
    }
  }
}