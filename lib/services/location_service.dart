// import 'package:location/location.dart';

// class LocationService {
//   Future<LocationData> getLocation() async {
//     Location location = Location();
//     bool _serviceEnabled;
//     LocationData _locationData;
//     PermissionStatus _permissionStatus;
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         throw Exception();
//       }
//     }
//     _permissionStatus = await location.hasPermission();
//     if (_permissionStatus == PermissionStatus.denied) {
//       _permissionStatus = await location.requestPermission();
//       if (_permissionStatus != PermissionStatus.granted) {
//         throw Exception();
//       }
//     }

//     _locationData = await location.getLocation();
//     return _locationData;
//   }
// }
