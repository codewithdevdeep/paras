import 'package:flutter/material.dart';

class AddressInput extends StatelessWidget {
  final TextEditingController destinationController;
  final void Function(String) onAddressSubmitted;

  AddressInput({
    required this.destinationController,
    required this.onAddressSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter destination address:',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          TextField(
            controller: destinationController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter address',
            ),
            onSubmitted: (value) {
              onAddressSubmitted(value);
            },
          ),
        ],
      ),
    );
  }
}
