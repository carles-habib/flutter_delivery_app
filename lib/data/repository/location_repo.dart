// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/constants/app_contsants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:delivery_app/data/api/api_client.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  List<Placemark> placemarks2 = [];

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    Response response = await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
    if (response.statusCode == 200) {
      print("tesssssssssssssst ${response.body.toString()}");
    }
    return response;
  }

  Future<List<Placemark>> test(double lat, double lon) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, lon, localeIdentifier: "en");
    print('placeeeeee ${placemarks[0].country} ${placemarks[0].street}');

    return placemarks;
  }
}
