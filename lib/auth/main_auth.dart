import 'package:flutter/material.dart';
import 'package:rayshop/constants/gaps.dart';

class MainAuthScreen extends StatelessWidget {
  const MainAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to RAYSHOP")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColor,
                ),
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "새 계정 만들기",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Gaps.v20,
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColor,
                ),
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "새 계정 만들기",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Gaps.v32,
            const Text("다른계정으로 로그인"),
            Gaps.v14,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircleAvatar(
                  child: Text("소셜"),
                ),
                CircleAvatar(
                  child: Text("소셜"),
                ),
                CircleAvatar(
                  child: Text("소셜"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
