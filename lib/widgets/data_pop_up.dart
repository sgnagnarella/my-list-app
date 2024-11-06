import 'package:flutter/material.dart';


class DataPopUp extends StatefulWidget {
  const DataPopUp({super.key});

  @override
  State<DataPopUp> createState() => _DataPopUp();
}

class _DataPopUp extends State<DataPopUp> {
  final TextEditingController
 _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min, // To prevent the column from taking up the entire screen
        children: [
          TextField(
            controller: _descriptionController,
            decoration:
 const InputDecoration(hintText: 'Item Description'),
          ),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Quantity'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Handle adding the item here
            String description = _descriptionController.text;
            String quantity = _quantityController.text;
            // ... your logic to add the item using description and quantity ...
            DataPopUpData data = DataPopUpData(description: description, quantity: int.parse(quantity));

            Navigator.of(context).pop(data); // Close the popup
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class DataPopUpData {
  final String description;
  final int quantity;

  DataPopUpData({required this.description, required this.quantity});
}