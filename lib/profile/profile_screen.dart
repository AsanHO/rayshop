import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rayshop/auth/main_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _onLogout() async {
    AuthManage().signOut();
    print("로그아웃되었습니다.");
    const storage = FlutterSecureStorage();
    await storage.delete(key: "email");
    await storage.delete(key: "password");
    var email = await storage.read(key: "email");
    var pw = await storage.read(key: "password");
    print(email);
    print(pw);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainAuthScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(onTap: _onLogout, child: const Text("로그아웃")),
      ),
    );
  }
}
