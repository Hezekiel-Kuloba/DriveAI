import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For Position type
import 'package:new_car_app/screens/utils/location.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class PlacesListScreen extends StatefulWidget {
  final String placeType;
  final String title;

  PlacesListScreen({required this.placeType, required this.title});

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  Position? _currentPosition;
  List<dynamic>? _places;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    // Use the LocationService to get the user's current location
    Position? position = await LocationService().getCurrentLocation(context);
    if (position != null) {
      try {
        var places = await LocationService().getNearbyPlaces(
            widget.placeType, position.latitude, position.longitude);
        setState(() {
          _currentPosition = position;
          _places = places;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to load places: $e")));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Failed to get location. Please enable location services.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _places == null || _places!.isEmpty
              ? Center(child: Text('No places found'))
              : ListView.builder(
                  itemCount: _places!.length,
                  itemBuilder: (context, index) {
                    var place = _places![index];
                    return ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(place['name']),
                      subtitle: Text(
                          "${place['vicinity']} - Rating: ${place['rating'] ?? 'N/A'}"),
                      onTap: () {
                        // Open Google Maps for directions
                        final lat = place['geometry']['location']['lat'];
                        final lng = place['geometry']['location']['lng'];
                        _launchMaps(lat, lng);
                      },
                    );
                  },
                ),
    );
  }

  // Open Google Maps with directions
  void _launchMaps(double lat, double lng) async {
    final googleMapsUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
}
