import 'package:fleetuser/views/Driver/deatailpage/deatailpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FuelForm extends StatefulWidget {
  @override
  _FuelFormState createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _formKey = GlobalKey<FormState>();
  String? _fuelType;
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _stationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Details'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Fuel Type',
                          border: OutlineInputBorder(),
                        ),
                        value: _fuelType,
                        items: ['CNG', 'Petrol', 'Diesel']
                            .map((label) => DropdownMenuItem(
                                  child: Text(label),
                                  value: label,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _fuelType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a fuel type';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Fuel Quantity',
                          border: OutlineInputBorder(),
                          suffixText: 'Liters',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the fuel quantity';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          prefixText: '₹ ',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the price';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _stationController,
                        decoration: InputDecoration(
                          labelText: 'Filling Station',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the filling station';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Start the Task',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () { Get.to(()=> DeliveryTrackingPage());
                
                },
                style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    print('Fuel Type: $_fuelType');
                    print('Quantity: ${_quantityController.text}');
                    print('Price: ${_priceController.text}');
                    print('Station: ${_stationController.text}');
                    // You can add your logic here to save or send the data
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}