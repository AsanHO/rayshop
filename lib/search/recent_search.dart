import 'package:flutter/material.dart';

class RecentSearch extends StatelessWidget {
  final String text;
  const RecentSearch({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close_sharp),
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
