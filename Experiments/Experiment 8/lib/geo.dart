import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoPage extends StatefulWidget {
  const GeoPage({Key? key}) : super(key: key);

  @override
  State<GeoPage> createState() => _GeoPageState();
}

class _GeoPageState extends State<GeoPage> {
  String _location = "Getting location...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = "Location services are disabled.";
      });
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _location = "Location permission denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _location = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _location =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Location Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://picsum.photos/200'),
            const SizedBox(height: 20),
            Text(_location),
          ],
        ),
      ),
    );
  }
}
