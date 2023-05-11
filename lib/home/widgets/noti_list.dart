import 'package:flutter/material.dart';
import 'package:rayshop/constants/gaps.dart';

class NotiList extends StatelessWidget {
  final Icon icon;
  final String text;
  final String daybefore;
  const NotiList({
    super.key,
    required this.text,
    required this.daybefore,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          Gaps.h20,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  softWrap: true,
                ),
                Gaps.v16,
                Text(
                  daybefore,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
