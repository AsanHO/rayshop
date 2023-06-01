import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:rayshop/auth/main_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rayshop/main_navigation/main_navigation_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  print("5월28일 업데이트 입니다:) 홈 스크린, 디테일 스크린 UI및 기능 개선");
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
      home:
          user != null ? const MainNavigationScreen() : const MainAuthScreen(),
    );
  }
}
