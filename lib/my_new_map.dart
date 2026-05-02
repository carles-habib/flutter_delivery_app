import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
//import "package:latlong/latlong.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;

class NewMapScreen extends StatelessWidget {
  final String apiKey = "GFd0NooVXt6dB9muM7EMdZVEMHv0wFea";

  @override
  Widget build(BuildContext context) {
    //final LatLng tomtomHQ = LatLng(52.376372, 4.908066);
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(initialZoom: 13.0),
              children: [
                TileLayer(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
