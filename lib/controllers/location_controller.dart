// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:delivery_app/data/repository/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });
  late List<Placemark> myPlace;
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlaceMark = Placemark();
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAdressList = [];
  List<String> _addressTypeList = ['home', 'office', 'others'];
  int _addressTypeIndex = 0;
  bool _updateAddressData = true;
  bool _changeAddress = true;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  bool get Loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
//*
  double lat = 0;
  double lon = 0;
  late GoogleMapController _mapController;
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          );
        } else {
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          );
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = 'Unkown location found';
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if (response.body["status"] == "OK") {
      _address = response.body['results'][0]['formatted_address'].toString();
      print('printed address ' + _address);
    } else {
      print('Error getting the google api');
    }
    return _address;
  }

  Future<void> test(double lat, double lon) async {
    myPlace = [];
    List<Placemark> placee = await locationRepo.test(lat, lon);
    myPlace = placee;
  }

  List<Placemark> getplace() {
    return myPlace;
  }
}
