import 'dart:convert';

import 'package:delivery_app/constants/app_contsants.dart';
import 'package:delivery_app/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.CART_LIST_KEY);
    // sharedPreferences.remove(AppConstants.CART_LIST_History_KEY);

    cart = [];
    var time = DateTime.now().toString();

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST_KEY, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST_KEY));
    //getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST_KEY)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST_KEY)!;
      //print('inside getList ' + carts.toString());
    }

    List<CartModel> cartList = [];

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_LIST_History_KEY)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_LIST_History_KEY)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.CART_LIST_History_KEY)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_LIST_History_KEY)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print('histry list ' + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_LIST_History_KEY, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST_KEY);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_LIST_History_KEY);
  }
}
