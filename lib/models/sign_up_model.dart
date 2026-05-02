import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignUpModel {
  final String name;
  final String email;
  final String password;
  final String phone;
  SignUpModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'f_name': name,
      'email': email,
      'password': password,
      'phone': phone
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
    );
  }
}
