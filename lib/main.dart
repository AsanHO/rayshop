import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:rayshop/auth/main_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rayshop/main_navigation/main_navigation_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  print("4월 3일 업데이트 입니다:) 로그인 영속성 추가");
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
      runApp(RayShopApp(isLogin: isSignedIn));
    } else {
      print("이메일 또는 비밀번호가 일치하지 않습니다.");
      runApp(RayShopApp(isLogin: isSignedIn));
    }
  } else {
    print("회원정보가 존재하지 않습니다..");
    runApp(const RayShopApp(isLogin: false));
  }
}

class RayShopApp extends StatelessWidget {
  final bool isLogin;
  const RayShopApp({Key? key, required this.isLogin}) : super(key: key);

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
      home: isLogin ? const MainNavigationScreen() : const MainAuthScreen(),
    );
  }
}
