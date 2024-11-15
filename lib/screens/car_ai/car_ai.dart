import 'package:flutter/material.dart';

class CarAIScreen extends StatefulWidget {
  const CarAIScreen({super.key});

  @override
  _CarAIScreenState createState() => _CarAIScreenState();
}

class _CarAIScreenState extends State<CarAIScreen> {
  // Controller for the search bar
  TextEditingController _searchController = TextEditingController();

  // Tracks if the query has been submitted
  bool _isQuerySubmitted = false;

  // Sample questions for car enthusiasts
  final List<String> sampleQuestions = [
    "What's the best fuel efficiency for electric cars?",
    "How do I maintain my car’s engine?",
    // "What are the latest car safety features?",
    "How do hybrid cars work?",
    "What is the best type of oil for my car?",
    "What are the top sports cars in 2024?",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Car AI Assistant'),
      //   backgroundColor: Colors.blueAccent, // OpenAI-like theme color
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the car enthusiast questions above the query input
            if (!_isQuerySubmitted) ...[
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                // child: Text(
                //   'Popular Questions:',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ),
              ...sampleQuestions
                  .map((question) => _buildQuestionChip(question)),
              const SizedBox(height: 20),
            ],

            // AI query input
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Ask anything about cars...',
                prefixIcon: const Icon(Icons.directions_car),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // "Ask AI" button to submit the query
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isQuerySubmitted = true;
                  });
                },
                icon: const Icon(Icons.send, size: 18),
                label: const Text(''),
                style: ElevatedButton.styleFrom(
                  // backgroundColor:
                  //     Colors.blueAccent, // Similar to OpenAI colors
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Results display after query submission
            if (_isQuerySubmitted)
              Expanded(
                child: Center(
                  child: Text(
                    'Searching for: ${_searchController.text}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget for rendering each question as a button or chip
  // Widget for rendering each question as a button or chip
  Widget _buildQuestionChip(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0), // Increase vertical padding
      child: GestureDetector(
        onTap: () {
          setState(() {
            _searchController.text = question;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.help_outline),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
