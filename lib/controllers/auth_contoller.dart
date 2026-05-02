import 'dart:convert'; // For json.decode
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';
import '../models/sign_up_model.dart'; // For rootBundle
// ... other imports

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Mock Registration
  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoaded = true;
    update();

    // In a local mock, we just "simulate" a successful save
    await Future.delayed(Duration(seconds: 1)); // Simulate network lag
    authRepo.saveUserToken("mock_token_123");

    _isLoaded = false;
    update();
    return ResponseModel(true, "mock_token_123");
  }

  // Mock Login
  Future<ResponseModel> login(String email, String password, String phone) async {
    _isLoaded = true; // This triggers the spinner in your UI
    update();

    try {
      final String response = await rootBundle.loadString('assets/json/users.json');
      final List<dynamic> users = json.decode(response);

      var user = users.firstWhere(
            (u) => (u['email'] == email || u['phone'] == phone) && u['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        authRepo.saveUserToken(user['token']);
        _isLoaded = false; // Turn off spinner
        update();
        return ResponseModel(true, user['token']);
      } else {
        _isLoaded = false; // Turn off spinner so user can try again
        update();
        return ResponseModel(false, "Invalid email or password");
      }
    } catch (e) {
      print("Login Error: $e");
      _isLoaded = false; // Turn off spinner on crash
      update();
      return ResponseModel(false, "Error accessing local data");
    }
  }
  // ... keep your existing helper methods
  bool uselLoggedIn() => authRepo.uselLoggedIn();
  bool clearSharedData() => authRepo.clearSharedData();
}