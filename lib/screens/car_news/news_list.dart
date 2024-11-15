import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<Map<String, dynamic>> posts = [
    {
      "username": "Toyota Kenya",
      "userProfilePic":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "postImage":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "caption": "New Toyota Kenya Garage Open, UpperHill! #ToyotaKenya",
      "likes": 124,
      "comments": 22,
      "isLiked": false,
      "isBookmarked": false,
      "dateTime": DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      "username": "Toyota Kenya",
      "userProfilePic":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "postImage":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "caption": "New Toyota Kenya Garage Open, UpperHill! #ToyotaKenya",
      "likes": 124,
      "comments": 22,
      "isLiked": false,
      "isBookmarked": false,
      "dateTime": DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      "username": "Toyota Kenya",
      "userProfilePic":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "postImage":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "caption": "New Toyota Kenya Garage Open, UpperHill! #ToyotaKenya",
      "likes": 124,
      "comments": 22,
      "isLiked": false,
      "isBookmarked": false,
      "dateTime": DateTime.now().subtract(Duration(hours: 5)),
    },
    // Add more posts here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostWidget(
          username: post["username"],
          userProfilePic: post["userProfilePic"],
          postImage: post["postImage"],
          caption: post["caption"],
          likes: post["likes"],
          comments: post["comments"],
          isLiked: post["isLiked"],
          isBookmarked: post["isBookmarked"],
          dateTime: post["dateTime"],
        );
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final String username;
  final String userProfilePic;
  final String postImage;
  final String caption;
  final int likes;
  final int comments;
  final bool isLiked;
  final bool isBookmarked;
  final DateTime dateTime;

  const PostWidget({
    required this.username,
    required this.userProfilePic,
    required this.postImage,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.isLiked,
    required this.isBookmarked,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userProfilePic),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text("Follow"),
                  onPressed: () {
                    // Navigate to the follow us screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FollowUsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      postImage,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border),
                      color: isLiked ? Colors.red : Colors.black,
                      onPressed: () {},
                    ),
                    Text(
                      '$likes likes',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text.rich(
              TextSpan(
                text: username,
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: ' $caption',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute} am',
              style: const TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class FollowUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follow Us'),
      ),
      body: Center(
        child: Text('Follow Us Screen Content'),
      ),
    );
  }
}
