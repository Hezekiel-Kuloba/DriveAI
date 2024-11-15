import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationService {
  // Request location permission
  final String _apiKey = 'AIzaSyBzshDiD9hIoR5hBdDYobdw1MRysfPyyE8';

  // Get nearby places based on the placeType (like gas station, etc.)
  Future<List<dynamic>> getNearbyPlaces(
      String placeType, double latitude, double longitude) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000&type=$placeType&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final places = data['results'] as List<dynamic>;
      return places;
    } else {
      throw Exception('Failed to load nearby places');
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request to turn on location
      return false;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentLocation(BuildContext context) async {
    bool hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Location permission not granted. Please enable it."),
      ));
      return null;
    }

    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best, // Same as the old 'desiredAccuracy'
        distanceFilter:
            100, // Optional: minimum distance (in meters) before location updates are triggered
      );

      return await Geolocator.getCurrentPosition(
        locationSettings:
            locationSettings, // Use the new 'locationSettings' parameter
      );
    } catch (e) {
      print('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error retrieving location. Please try again."),
      ));
      return null;
    }
  }
}
