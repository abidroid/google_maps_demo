import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityMapScreen extends StatefulWidget {
  const CityMapScreen({super.key});

  @override
  State<CityMapScreen> createState() => _CityMapScreenState();
}

class _CityMapScreenState extends State<CityMapScreen> {
  TextEditingController cityC = TextEditingController();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(34.0151, 71.5249),
    zoom: 14.4746,
  );

  @override
  initState() {
    markers.add(const Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.0151, 71.5249),
      infoWindow: InfoWindow(title: 'Peshawar', snippet: 'I am in Peshawar'),
    ));
    super.initState();
  }

  Set<Marker> markers = {};
  @override
  void dispose() {
    cityC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peshawar'),
      ),
      body: Column(
        children: [
          TextField(
            controller: cityC,
          ),
          ElevatedButton(
            onPressed: () async {
              String cityName = cityC.text.trim();

              if (cityName.isNotEmpty) {
                List<Location> locations = await locationFromAddress(cityName);

                Fluttertoast.showToast(msg: 'Total locations ${locations.length}');
                print(locations.length);

                if (locations.isNotEmpty) {
                  Location location = locations[0];

                  cameraPosition = CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 14.4746,
                  );

                  markers.add(Marker(
                    markerId: MarkerId(cityName),
                    position: LatLng(location.latitude, location.longitude),
                    infoWindow: InfoWindow(title: cityName, snippet: 'I am in $cityName'),
                  ));

                  GoogleMapController controller = await _controller.future;
                  controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

                  setState(() {});
                }
              } else {}
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (LatLng location) {
                markers.add(Marker(
                  markerId: MarkerId(location.toString()),
                  position: LatLng(location.latitude, location.longitude),
                  //infoWindow: InfoWindow(title: cityName, snippet: 'I am in $cityName'),
                ));
                setState(() {});
              },
              mapType: MapType.satellite,
              markers: markers,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )
        ],
      ),
    );
  }
}
