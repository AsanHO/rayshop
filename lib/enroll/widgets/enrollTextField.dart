import 'package:flutter/material.dart';

class EnrollTextField extends StatefulWidget {
  final String title;
  final bool showCheckbox;
  const EnrollTextField({
    super.key,
    required this.title,
    required this.showCheckbox,
  });

  @override
  State<EnrollTextField> createState() => _EnrollTextFieldState();
}

class _EnrollTextFieldState extends State<EnrollTextField> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                widget.showCheckbox
                    ? Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value as bool;
                              });
                            },
                          ),
                          const Text(
                            '무료배송',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ],
        ),
        const TextField(
          style: TextStyle(fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
