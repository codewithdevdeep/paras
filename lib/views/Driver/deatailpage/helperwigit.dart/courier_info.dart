import 'package:flutter/material.dart';

class CourierInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Courier Information',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          // Replace with actual data
          Text('Name: John Doe'),
          Text('Phone: +123456789'),
          Text('Vehicle: Bike'),
        ],
      ),
    );
  }
}
