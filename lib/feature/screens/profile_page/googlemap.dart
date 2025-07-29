import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.693257, 85.281562);
  LatLng myLocation1 = const LatLng(27.692718, 85.281958);
  @override
  void initState() {
    markers.add(
      Marker(
        markerId: MarkerId(myLocation.toString()),
        position: myLocation,
        infoWindow: const InfoWindow(
          title: 'Bagaicha Florashop',
          snippet: 'This is my office',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId(myLocation1.toString()),
        position: myLocation1,
        infoWindow: const InfoWindow(
          title: 'Bagaicha Florashop',
          snippet: 'Kathmandu Branch office',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bagaicha Florashop Location Map",
            style: TextStyle(color: Colors.white)),
        // backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "My Location",
                  style: TextStyle(
                    color: Color.fromARGB(255, 23, 173, 63),
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: GoogleMap(
                zoomControlsEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: myLocation,
                  zoom: 10,
                ),
                markers: markers,
                mapType: MapType.normal,
                onMapCreated: ((controller) => _mapController = controller),
              ),
            )
          ],
        ),
      ),
    );
  }
}
