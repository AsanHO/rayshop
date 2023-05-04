import 'package:flutter/material.dart';

class RecentSearch extends StatelessWidget {
  final String text;
  const RecentSearch({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close_sharp),
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
