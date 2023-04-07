import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rayshop/auth/main_auth.dart';
import 'package:rayshop/profile/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: const Text(
              "내 계정",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: const Column(
          children: [],
        ));
  }
}
