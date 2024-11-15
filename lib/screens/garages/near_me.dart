import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For Position type
import 'package:new_car_app/screens/utils/location.dart'; // Ensure you have this service
import 'package:url_launcher/url_launcher.dart'; // For launching URLs

class GaragesNearMe extends StatefulWidget {
  const GaragesNearMe({Key? key}) : super(key: key);

  @override
  _GaragesNearMeState createState() => _GaragesNearMeState();
}

class _GaragesNearMeState extends State<GaragesNearMe> {
  Position? _currentPosition;
  List<dynamic>? _places;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    // Get user's current location
    Position? position = await LocationService().getCurrentLocation(context);
    if (position != null) {
      try {
        var places = await LocationService().getNearbyPlaces(
            "car_repair", position.latitude, position.longitude);

        // Filter top 5 garages with the highest rating
        places.sort((a, b) {
          var ratingA = a['rating'] ?? 0;
          var ratingB = b['rating'] ?? 0;
          return ratingB.compareTo(ratingA);
        });
        places = places.take(5).toList(); // Only take the top 5

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
    return Column(
      children: [
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _places == null || _places!.isEmpty
                ? const Center(
                    child: Text(
                      'Turn on your location to see garages near you',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _places!.length,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disables scrolling
                      itemBuilder: (context, index) {
                        var place = _places![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0), // Reduce vertical spacing
                          child: ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(place['name']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(place['vicinity']),
                                const SizedBox(
                                    height:
                                        4.0), // Slight spacing between vicinity and rating
                                _buildRatingStars(place[
                                    'rating']), // Function to display stars
                                const SizedBox(height: 4.0), // Slight spacing
                                // Display phone number if available
                                if (place['formatted_phone_number'] != null)
                                  Text(
                                      'Phone: ${place['formatted_phone_number']}'),
                                const SizedBox(height: 4.0), // Slight spacing
                                // Display opening hours if available
                                if (place['opening_hours'] != null &&
                                    place['opening_hours']['weekday_text'] !=
                                        null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Opening Hours:'),
                                      for (var hour in place['opening_hours']
                                          ['weekday_text'])
                                        Text(hour),
                                    ],
                                  ),
                              ],
                            ),
                            onTap: () {
                              // Open Google Maps for directions
                              final lat = place['geometry']['location']['lat'];
                              final lng = place['geometry']['location']['lng'];
                              _launchMaps(lat, lng);
                            },
                          ),
                        );
                      },
                    ),
                  ),
      ],
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

  /// Function to create star ratings
  Widget _buildRatingStars(dynamic rating) {
    if (rating == null) return const Text("Rating: N/A");

    // Convert rating to double, even if it comes as an int
    double ratingValue = rating is int ? rating.toDouble() : rating;

    int fullStars = ratingValue.floor(); // Full stars
    bool hasHalfStar =
        (ratingValue - fullStars) >= 0.5; // Check if there’s a half star

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 16.0);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16.0);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 16.0);
        }
      }),
    );
  }
}
