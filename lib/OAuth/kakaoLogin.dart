import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() {
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KakaoLogin',
      home: const MainAuthScreen(),
    );
  }
}
