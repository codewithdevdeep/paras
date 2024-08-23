import 'package:flutter/material.dart';

class PackageStatus extends StatelessWidget {
  final double distanceInKm;

  PackageStatus({required this.distanceInKm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Package Status',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          // Replace with actual data
          Text('Status: In Transit'),
          Text('Estimated Distance: ${distanceInKm.toStringAsFixed(2)} km'),
        ],
      ),
    );
  }
}
