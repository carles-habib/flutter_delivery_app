// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductsModel> _products;
  List<ProductsModel> get products => _products;
  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((v) {
        _products.add(ProductsModel.fromJson(v));
      });
    }
  }
}

class ProductsModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductsModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'stars': this.stars,
      'img': this.img,
      'location': this.location,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'typeId': this.typeId,
    };
  }

  ProductsModel.fromJson(Map<String, dynamic> json) {
    // Use .toString() and int.tryParse to be safe
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    name = json['name'];
    description = json['description'];

    // Safe parsing for price
    price = json['price'] is int ? json['price'] : int.tryParse(json['price'].toString());

    stars = json['stars'] is int ? json['stars'] : int.tryParse(json['stars'].toString());
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    typeId = json['type_id'] is int ? json['type_id'] : int.tryParse(json['type_id'].toString());
  }
}
