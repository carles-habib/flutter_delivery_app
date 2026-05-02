import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'orderCount': orderCount,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['f_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      orderCount: json['order_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());
}
