import 'package:flutter/material.dart';

class ShipperInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipper Information',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          // Replace with actual data
          Text('Name: Jane Smith'),
          Text('Phone: +987654321'),
          Text('Address: 123 Main St, Anytown, USA'),
        ],
      ),
    );
  }
}
