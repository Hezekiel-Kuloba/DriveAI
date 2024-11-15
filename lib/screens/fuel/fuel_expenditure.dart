import 'package:flutter/material.dart';

class fuelExpenditureSlider extends StatefulWidget {
  fuelExpenditureSlider({super.key});

  final List<Map<String, String>> services = [
    {"monthly_expenditure": "10,000"},
    {"daily_expenditure": "20,000"},
  ];

  @override
  _fuelExpenditureSliderState createState() => _fuelExpenditureSliderState();
}

class _fuelExpenditureSliderState extends State<fuelExpenditureSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Expenditures',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180, // Set a fixed height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.services.length,
            itemBuilder: (context, index) {
              String expenditureType = widget.services[index].keys.first;
              String expenditureValue = widget.services[index].values.first;
              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: buildExpenditureCard(expenditureType, expenditureValue),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for displaying a single expenditure card with an edit button
  Widget buildExpenditureCard(String expenditureType, String expenditureValue) {
    IconData icon;
    String label;

    switch (expenditureType) {
      case 'monthly_expenditure':
        icon = Icons.calendar_today;
        label = "Monthly Expenditure";
        break;
      case 'daily_expenditure':
        icon = Icons.today;
        label = "Daily Expenditure";
        break;
      default:
        icon = Icons.help_outline;
        label = "Expenditure";
        break;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3, // Slight elevation for a more professional look
      child: Container(
        width: 140, // Adjust the width of each card
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              expenditureValue,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  _showEditDialog(context, expenditureType, expenditureValue);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shows a dialog for editing expenditure details
  void _showEditDialog(
      BuildContext context, String expenditureType, String currentValue) {
    final TextEditingController _controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $expenditureType'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter new value'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  // Update the expenditure value
                  final index = widget.services.indexWhere(
                      (service) => service.values.first == currentValue);
                  if (index != -1) {
                    widget.services[index] = {
                      widget.services[index].keys.first: _controller.text
                    };
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
