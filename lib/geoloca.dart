import 'dart:async';
import 'dart:io' show Platform;

import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Demo',
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _latitude = '';
  String _longitude = '';

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  void _checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      _getCurrentLocation();
    } else if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      // Handle the scenario where the user denied access to location services
      // You can show a dialog explaining why the app needs access to location services
    } else {
      await Permission.location.request();
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      });
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: $_latitude',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Longitude: $_longitude',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}