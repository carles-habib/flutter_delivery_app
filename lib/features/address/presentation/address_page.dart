// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:delivery_app/controllers/auth_contoller.dart';
import 'package:delivery_app/controllers/location_controller.dart';
import 'package:delivery_app/controllers/user_controller.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  var locationController = Get.find<LocationController>();
  TextEditingController _adressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoding;
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.515343, 36.289590),
    zoom: 17,
  );
  late LatLng _intialPosition = LatLng(33.515343, 36.289590);

  @override
  void initState() {
    super.initState();
    _isLoding = Get.find<AuthController>().uselLoggedIn();
    if (_isLoding && Get.find<UserController>().getUserData() == null) {
      Get.find<UserController>().getUserData();
    }
    if (locationController.addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(locationController.getAddress['latitude']),
        double.parse(locationController.getAddress['longitude']),
      ));
      _intialPosition = LatLng(
        double.parse(locationController.getAddress['latitude']),
        double.parse(locationController.getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address page'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 6, left: 5, top: 5),
              height: 140,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(width: 2, color: Theme.of(context).primaryColor),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _intialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraIdle: () {
                      locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: (GoogleMapController controller) {
                      locationController.setMapController(controller);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
