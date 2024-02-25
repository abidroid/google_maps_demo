import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_demo/city_map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPeshawarScreen extends StatefulWidget {
  const MyPeshawarScreen({super.key});

  @override
  State<MyPeshawarScreen> createState() => _MyPeshawarScreenState();
}

class _MyPeshawarScreenState extends State<MyPeshawarScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition myPeshawar = CameraPosition(
    target: LatLng(34.0151, 71.5249),
    zoom: 14.4746,
  );

  Set<Marker> markers = {};

  @override
  void initState() {
    markers.add(const Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.0151, 71.5249),
      infoWindow: InfoWindow(title: 'Peshawar', snippet: 'I am in Peshawar'),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const CityMapScreen();
          }));
        },
        child: const Icon(Icons.location_on),
      ),
      appBar: AppBar(
        title: const Text('Peshawar'),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        markers: markers,
        initialCameraPosition: myPeshawar,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
