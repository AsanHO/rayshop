import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:rayshop/auth/main_auth.dart';

class naver_Login extends StatefulWidget {
  const naver_Login({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

void signInWithNaver() async {
  NaverLoginResult res = await FlutterNaverLogin.logIn();
  final NaverLoginResult result = await FlutterNaverLogin.logIn();
  NaverAccessToken req = await FlutterNaverLogin.currentAccessToken;
}
