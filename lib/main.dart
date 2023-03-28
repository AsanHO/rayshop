import 'package:flutter/material.dart';
import 'package:rayshop/auth/main_auth.dart';

void main() {
  print("3월 26일 업데이트 입니다:)");
  runApp(const RayShopApp());
}

class RayShopApp extends StatelessWidget {
  const RayShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RayShop',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        cardColor: const Color(0xffffea27),
        errorColor: const Color(0xffff6427),
        primaryColor: const Color(0xff247dff),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainAuthScreen(),
    );
  }
}
