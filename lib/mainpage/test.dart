import 'package:flutter/material.dart';

// Define your custom model class
class CustomModel {
  final int id;
  final String status;

  CustomModel({required this.id, required this.status});
}

// Sample list of custom model objects
 List<CustomModel> customList = [
  CustomModel(id: 1, status: 'Active'),
  CustomModel(id: 2, status: 'Inactive'),
  CustomModel(id: 3, status: 'Pending'),
  CustomModel(id: 4, status: 'Completed'),
];



class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Center(
          child: DropdownMenuExample(),
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({Key? key}) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  CustomModel dropdownValue = customList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CustomModel>(
      initialSelection: customList.first,
      onSelected: (CustomModel? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: customList.map<DropdownMenuEntry<CustomModel>>((CustomModel model) {
        return DropdownMenuEntry<CustomModel>(
          value: model,
          label: model.status,
        );
      }).toList(),
    );
  }
}

// Custom DropdownMenu widget implementation (not provided in Flutter SDK)
class DropdownMenu<T> extends StatelessWidget {
  final T initialSelection;
  final ValueChanged<T?>? onSelected;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  const DropdownMenu({
    Key? key,
    required this.initialSelection,
    required this.onSelected,
    required this.dropdownMenuEntries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: initialSelection,
      onChanged: onSelected,
      items: dropdownMenuEntries,
    );
  }
}

// Custom DropdownMenuEntry widget implementation (not provided in Flutter SDK)
class DropdownMenuEntry<T> extends DropdownMenuItem<T> {
  final T value;
  final String label;

  DropdownMenuEntry({
    required this.value,
    required this.label,
  }) : super(
          value: value,
          child: Text(label),
        );
}
