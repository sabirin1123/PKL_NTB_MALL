import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class detailPage extends StatefulWidget {
  const detailPage({Key? key}) : super(key: key);

  @override
  detailPageState createState() => detailPageState();
}

class detailPageState extends State<detailPage> {
  GoogleMapController? mapController;

  LatLng m = LatLng(-8.749366, 117.570633);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void buildDetail(BuildContext context) => Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: m, zoom: 10),
          onMapCreated: (controller) {
            controller;
          },
        ),
      );

  Widget _buildMap(BuildContext context, double lat, double lang) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: m, zoom: 10),
          onMapCreated: (controller) {
            controller;
          },
          // markers: Set<Marker>.of(markers),
        ),
      );
}
