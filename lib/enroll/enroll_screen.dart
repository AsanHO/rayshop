import 'package:flutter/material.dart';

class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Enroll")),
    );
  }
}
