import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_car_app/screens/utils/location.dart'; // LocationService assumed here
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrafficScreen extends StatefulWidget {
  const TrafficScreen({super.key});

  @override
  _TrafficScreenState createState() => _TrafficScreenState();
}

class _TrafficScreenState extends State<TrafficScreen> {
  GoogleMapController? _controller;
  bool _isTrafficEnabled = true;
  Position? _currentPosition;
  Set<Marker> _trafficMarkers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Fetch traffic data from API and update the markers
  Future<void> _fetchTrafficData() async {
    // Assuming traffic data API gives traffic levels and location
    final String trafficApiUrl =
        'https://api.traffic.com/v1/data?location=${_currentPosition?.latitude},${_currentPosition?.longitude}';
    final response = await http.get(Uri.parse(trafficApiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> trafficData = data['trafficConditions'];

      setState(() {
        _trafficMarkers = trafficData.map((traffic) {
          LatLng position = LatLng(traffic['lat'], traffic['lng']);
          String condition = traffic['condition']; // high, medium, low

          return Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            icon: _getTrafficIcon(
                condition), // Custom method to get the icon based on traffic level
            infoWindow: InfoWindow(
              title: 'Traffic: $condition',
              snippet: 'At location ${traffic['locationName']}',
            ),
          );
        }).toSet();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to load traffic data'),
      ));
    }
  }

  // Helper method to get different icons for traffic conditions
  BitmapDescriptor _getTrafficIcon(String condition) {
    switch (condition) {
      case 'high':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'medium':
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange);
      case 'low':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  Future<void> _getCurrentLocation() async {
    Position? position = await LocationService().getCurrentLocation(context);
    if (position != null) {
      setState(() {
        _currentPosition = position;
      });

      // Move the camera to the user's current location
      _controller?.moveCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        14, // Zoom level
      ));

      // Fetch traffic data after getting current location
      _fetchTrafficData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Failed to get location. Please enable location services.'),
      ));
    }
  }

  void _toggleTraffic() {
    setState(() {
      _isTrafficEnabled = !_isTrafficEnabled;
    });

    // Set custom map style for traffic or reset it
    _controller?.setMapStyle(_isTrafficEnabled
        ? '[{"featureType":"road","elementType":"all","stylers":[{"visibility":"simplified"}]}]'
        : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Conditions'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchTrafficData, // Refresh traffic data manually
          ),
        ],
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    if (_currentPosition != null) {
                      controller.moveCamera(CameraUpdate.newLatLngZoom(
                        LatLng(_currentPosition!.latitude,
                            _currentPosition!.longitude),
                        14,
                      ));
                    }
                  },
                  markers: _trafficMarkers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition?.latitude ??
                          -1.2921, // Default to Nairobi
                      _currentPosition?.longitude ?? 36.8219,
                    ),
                    zoom: 12,
                  ),
                  trafficEnabled: _isTrafficEnabled, // Show or hide traffic
                ),
                _buildTrafficLegend(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTraffic,
        child: Icon(_isTrafficEnabled ? Icons.traffic : Icons.map),
      ),
    );
  }

  // Traffic legend widget
  Widget _buildTrafficLegend() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLegendItem(Colors.red, "High Traffic"),
          _buildLegendItem(Colors.orange, "Medium Traffic"),
          _buildLegendItem(Colors.green, "Low Traffic"),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
