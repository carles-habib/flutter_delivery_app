// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/data/repository/popular_product_repo.dart';
import 'package:delivery_app/models/cart_model.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem + _quantity;

  List<dynamic> get popularProductList => _popularProductList;
  Future<void> getPopularProductList() async {
    try {
      String response = await rootBundle.loadString('assets/json/popular_products.json');

      List<dynamic> data = json.decode(response);

      // 3. Clear and Map to your model
      _popularProductList = [];
      _popularProductList.addAll(data.map((item) => ProductsModel.fromJson(item)).toList());

      _isLoaded = true;
      update();
    } catch (e) {
      print("Error loading local JSON: $e");
    }
  }

  void setQuantity(bool isIncement) {
    if (isIncement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if ((_inCartItem + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItem > 0) {
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItem + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel product, CartController cartController) {
    _quantity = 0;
    _inCartItem = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.isExistInCart(product);
    // print('exist or not' + exist.toString());
    if (exist) {
      _inCartItem = cartController.getQuantity(product);
    }
    // print('quantity in cart ' + _inCartItem.toString());
  }

  void addItem(ProductsModel productsModel) {
    //if (_quantity > 0) {
    _cartController.addItem(productsModel, _quantity);
    _quantity = 0;
    _inCartItem = _cartController.getQuantity(productsModel);
    _cartController.Items.forEach((key, value) {
      print('the id is ' +
          value.id.toString() +
          'the quantity is ' +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
