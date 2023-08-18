import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:rayshop/auth/main_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rayshop/main_navigation/main_navigation_screen.dart';
import 'firebase_options.dart';

void main() async {
  print("8월19일 업데이트 입니다:) 임시 스플래시 화면 추가");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const storage = FlutterSecureStorage();
  var email = await storage.read(key: "email");
  var pw = await storage.read(key: "password");
  print(email);
  print(pw);
  if (email != null && pw != null) {
    final isSignedIn = await AuthManage().signIn(email, pw);
    if (isSignedIn) {
      runApp(const RayShopApp());
    } else {
      print("이메일 또는 비밀번호가 일치하지 않습니다.");
      runApp(const RayShopApp());
    }
  } else {
    print("회원정보가 존재하지 않습니다..");
    runApp(const RayShopApp());
  }
}

class RayShopApp extends StatefulWidget {
  const RayShopApp({Key? key}) : super(key: key);

  @override
  State<RayShopApp> createState() => _RayShopAppState();
}

class _RayShopAppState extends State<RayShopApp> {
  User? user = AuthManage().getUser();
  bool _showSplash = true; // 스플래시 화면 표시 여부

  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  // 스플래시 화면 표시 후 일정 시간 뒤에 메인 화면으로 전환
  Future<void> _loadSplash() async {
    await Future.delayed(const Duration(seconds: 3)); // 스플래시 화면 표시 시간 설정
    setState(() {
      _showSplash = false; // 스플래시 화면 표시 종료
    });
  }

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
      home: _showSplash
          ? const SplashScreen()
          : (user != null
              ? const MainNavigationScreen()
              : const MainAuthScreen()),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/character.png'), // 스플래시 이미지 표시
      ),
    );
  }
}
