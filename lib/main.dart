import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth/main_auth.dart';
import 'firebase_options.dart';
import 'package:video_player/video_player.dart';

import 'main_navigation/main_navigation_screen.dart';

void main() async {
  print("8월29일 업데이트 입니다 검색 기능 구현 , 최신 버젼");
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
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  User? user = AuthManage().getUser();
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/rayshopsplash.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            _controller.pause();

            // 비디오 재생이 완료되면 user가 null인 경우 MainAuthScreen으로 이동
            if (user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainAuthScreen()),
              );
            }
            // user가 null이 아니라면 MainNavigationScreen으로 이동
            else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen()),
              );
            }
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // 비디오 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
