import 'package:flutter/material.dart';
import 'package:rayshop/auth/main_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  print("3월 30일 업데이트 입니다:) 등록 화면 추가");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        primaryColor: const Color(0xff247dff),
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
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(error: const Color(0xffff6427)),
      ),
      home: const MainAuthScreen(),
    );
  }
}
