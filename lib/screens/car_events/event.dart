import 'package:flutter/material.dart';

class EventFeedScreen extends StatelessWidget {
  final List<Map<String, dynamic>> events = [
    {
      "eventName": "New Toyota Garage Opening",
      "eventImage":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "location": "Nairobi, Kenya",
      "eventDate": DateTime.now().add(Duration(days: 3)),
      "about":
          "Join us for the grand opening of our new garage in Upper Hill, Nairobi. Enjoy special discounts and free consultations!",
      "likes": 124,
      "comments": 22,
      "isBooked": false,
    },
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return EventWidget(
          eventName: event["eventName"],
          eventImage: event["eventImage"],
          location: event["location"],
          eventDate: event["eventDate"],
          about: event["about"],
          likes: event["likes"],
          comments: event["comments"],
          isBooked: event["isBooked"],
          context: context,
        );
      },
    );
  }
}

class EventWidget extends StatelessWidget {
  final String eventName;
  final String eventImage;
  final String location;
  final DateTime eventDate;
  final String about;
  final int likes;
  final int comments;
  final bool isBooked;
  final BuildContext context;

  const EventWidget({
    required this.eventName,
    required this.eventImage,
    required this.location,
    required this.eventDate,
    required this.about,
    required this.likes,
    required this.comments,
    required this.isBooked,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Coming soon',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
      ),
    );
    // return Card(
    //   margin: const EdgeInsets.symmetric(vertical: .0, horizontal: 16.0),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   elevation: 0,
    //   child: Column(
    //     // crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Location and Date Section Above the Image
    //       Padding(
    //         padding: const EdgeInsets.only(top: 5, bottom: 10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Event Date: ${eventDate.day}/${eventDate.month}/${eventDate.year}',
    //             ),
    //             const SizedBox(height: 4), // Space between date and location
    //             Text(
    //               '${location}',
    //             ),
    //           ],
    //         ),
    //       ),
    //       // Event Image
    //       Padding(
    //         padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.9,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(20.0),
    //                 child: Image.network(
    //                   eventImage,
    //                   height: 250,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding:
    //             const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    //         child: Row(
    //           children: [
    //             const Icon(Icons.favorite), // Heart icon
    //             const SizedBox(width: 5),
    //             Text(
    //               '$likes Likes',
    //               style: const TextStyle(color: Colors.black54),
    //             ),
    //             const SizedBox(width: 20), // Space between icons
    //             const Icon(Icons.comment),
    //             const SizedBox(width: 5),
    //             Text(
    //               '$comments Comments',
    //               style: const TextStyle(color: Colors.black54),
    //             ),
    //             const SizedBox(width: 20), // Space between icons
    //             const Icon(Icons.share),
    //             const SizedBox(width: 5),
    //             const Text(
    //               'Share',
    //               style: TextStyle(color: Colors.black54),
    //             ),
    //           ],
    //         ),
    //       ),
    //       // Event Name
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           eventName,
    //           style: const TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //       // About Section
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //         child: Text(
    //           '$about',
    //           style: const TextStyle(color: Colors.black54),
    //         ),
    //       ),
    //       // Likes, Comments, and Share Section

    //       // View All Comments Button
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //         child: TextButton(
    //           onPressed: () {
    //             // Action for viewing all comments
    //           },
    //           child: const Text(
    //             'View all comments',
    //           ),
    //         ),
    //       ),
    //       // Booking Button
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ElevatedButton(
    //           onPressed: isBooked
    //               ? null // Disable button if already booked
    //               : () {
    //                   // Navigate to the booking screen
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => BookingScreen()),
    //                   );
    //                 },
    //           child: Text(isBooked ? 'Booked' : 'Book Event'),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Screen'),
      ),
      body: Center(
        child: const Text('Booking Screen Content'),
      ),
    );
  }
}
