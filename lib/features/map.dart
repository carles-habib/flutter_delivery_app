// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/services/location_s.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/widgets/app_icon.dart';
import 'package:delivery_app/widgets/big_text.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(33.515343, 36.289590), zoom: 14.33);
  List<Placemark> placemarks2 = [];

  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(44.515343, 36.289590),
      infoWindow: InfoWindow(title: 'myTitle'),
    ),
  ];

  LatLng currentLocation = _cameraPosition.target;
  @override
  void initState() {
    super.initState();
    // test();
  }

  Future<void> test() async {
    try {
      setState(() async {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentLocation.latitude, currentLocation.longitude,
            localeIdentifier: "en");
        print('placeeeeee ${placemarks[0].country} ${placemarks[0].street}');
        placemarks2 = placemarks;
      });
    } catch (e) {
      print('placee erorrrrrrrrrrrrr $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(right: 5, left: 5, top: 5),
              height: 450,
              width: double.maxFinite,
              child: GoogleMap(
                initialCameraPosition: _cameraPosition,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController googleMapController) {
                  _controller.complete(googleMapController);
                },
                onCameraMove: (CameraPosition newpos) {
                  setState(() {
                    currentLocation = newpos.target;
                  });
                },
                markers: Set<Marker>.of(_markers),
              ),
            ),
            const SizedBox(height: 25),
            InfoWidget(
              text: placemarks2.isEmpty
                  ? "test"
                  : "${placemarks2[0].country}  ${placemarks2[0].street}",
              icon: Icons.location_city,
            ),
            const InfoWidget(
              text: "name",
              icon: Icons.person,
            ),
            const InfoWidget(
              text: "Phone",
              icon: Icons.location_city,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _getMyLocation();
            test();
          },
          child: const Icon(Icons.gps_fixed),
        ),
        // bottomNavigationBar: Container(
        //   height: 30,
        //   alignment: Alignment.center,
        //   child: Text(
        //       "lat: ${currentLocation.latitude}, lng:${currentLocation.longitude},  "),
        // ),
      ),
    );
  }

  Future<void> _getMyLocation() async {
    Position geolocator = await myClass().determinePosition();
    _markers.add(
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(geolocator.latitude, geolocator.longitude),
        infoWindow: InfoWindow(
            title: 'lat: ${geolocator.latitude} lon: ${geolocator.longitude} '),
      ),
    );

    animateCamera(geolocator);
  }

  Future<void> animateCamera(Position position) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
    print(
      "animate camera to (lat: ${position.latitude}, lng:${position.longitude}",
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            onTap: () {},
            backroundColor: AppColors.mainColor,
            iconColor: Colors.white,
          ),
          const SizedBox(width: 15),
          BigText(text: text),
        ],
      ),
    );
  }
}
