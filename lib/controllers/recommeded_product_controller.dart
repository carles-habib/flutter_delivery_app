import 'dart:convert';

import 'package:delivery_app/data/repository/recomended_product_repo.dart';
import 'package:delivery_app/models/products_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecomendedProductRepo recomendedProductRepo;
  RecommendedProductController({required this.recomendedProductRepo});
  List<dynamic> _recommendProductList = [];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<dynamic> get recommendedProductList => _recommendProductList;
  Future<void> getRecomededProductList() async {
    try{
      String response = await rootBundle.loadString('assets/json/recommended_products.json');
      List<dynamic> data = json.decode(response);
      _recommendProductList = [];
      _recommendProductList.addAll(data.map((item) => ProductsModel.fromJson(item)).toList());

      _isLoaded = true;
      update();

    }catch(e){
      print("Error loading recommended products from local JSON");
    }

  }
}
