import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Icon icon;
  const Button({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        height: 90,
        width: screenWidth * 0.43,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              icon,
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
