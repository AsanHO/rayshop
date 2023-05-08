import 'package:flutter/material.dart';

class NotiCategory extends StatefulWidget {
  final String text;
  const NotiCategory({super.key, required this.text});

  @override
  State<NotiCategory> createState() => _NotiCategoryState();
}

class _NotiCategoryState extends State<NotiCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
