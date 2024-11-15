import 'package:flutter/material.dart';

class CarProfilePage extends StatelessWidget {
  final String profilePic =
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png";
  final String postImage =
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png";

  final int followers = 250000;
  final int likes = 200000;
  final int posts = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Toyota'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Profile Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePic),
                ),
              ],
            ),
          ),

          // Profile Info (Followers, Likes, Posts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn('Followers', followers),
                _buildInfoColumn('Likes', likes),
                _buildInfoColumn('Posts', posts),
              ],
            ),
          ),

          // Follow button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  // Follow action here
                },
                child: Text('Follow'),
              ),
            ),
          ),

          Divider(thickness: 1, color: Colors.grey[300]),

          // Posts Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 10, // Replace with the number of posts
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return PostTile(imageUrl: postImage);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build Followers, Likes, Posts info
  Widget _buildInfoColumn(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Widget for individual post tiles
class PostTile extends StatelessWidget {
  final String imageUrl;

  const PostTile({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CarProfilePage(),
  ));
}
