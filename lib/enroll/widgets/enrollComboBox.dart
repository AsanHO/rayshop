import 'package:flutter/material.dart';

class EnrollComboBox extends StatefulWidget {
  List list;
  String selectedValue;
  EnrollComboBox({
    super.key,
    required this.list,
    required this.selectedValue,
  });

  @override
  State<EnrollComboBox> createState() => _EnrollComboBoxState();
}

class _EnrollComboBoxState extends State<EnrollComboBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        value: widget.selectedValue,
        items: widget.list.map(
          (value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        onChanged: (value) {
          setState(
            () {
              widget.selectedValue = value as String;
            },
          );
        },
      ),
    );
  }
}
