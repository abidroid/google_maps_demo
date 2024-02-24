import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPeshawarScreen extends StatefulWidget {
  const MyPeshawarScreen({super.key});

  @override
  State<MyPeshawarScreen> createState() => _MyPeshawarScreenState();
}

class _MyPeshawarScreenState extends State<MyPeshawarScreen> {


  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition myPeshawar = CameraPosition(
    target: LatLng(34.0151, 71.5249),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peshawar'),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: myPeshawar,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
