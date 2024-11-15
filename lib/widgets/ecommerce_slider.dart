import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EcommerceSlider extends StatefulWidget {
  EcommerceSlider({super.key});

  final Map<String, dynamic> Ecommerce = {
    "images": [
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png",
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719553/iris3_cbjjxp.png",
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
    ]
  };

  @override
  _EcommerceSliderState createState() => _EcommerceSliderState();
}

class _EcommerceSliderState extends State<EcommerceSlider> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> sliderItems = widget.Ecommerce['images']
        .map<Widget>((imageUrl) => buildImageSlider(imageUrl))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: sliderItems,
          options: CarouselOptions(
            height: 150,
            autoPlay: true, // Enable auto-play
            autoPlayInterval:
                const Duration(seconds: 5), // Auto-play every 5 seconds
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: sliderItems.length,
            effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.black,
              dotColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // Widget for displaying car image inside a card
  Widget buildImageSlider(String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover, // Ensures the image covers the card
          ),
        ),
      ),
    );
  }
}
