import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:rayshop/auth/login_screen.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rayshop/main_navigation/main_navigation_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAuthScreen extends StatefulWidget {
  const MainAuthScreen({super.key});

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  void kakaoLogin() {
    KakaoSdk.init(nativeAppKey: '664d3082d3585c9e23f8c37092ac30d5');
  }

  //네이놈
  @override
  void initState() {
    super.initState();
    FlutterNaverLogin.initSdk(
        clientId: 'HCLGtp5tKSGfh8HX2S4H',
        clientSecret: 'JoK4trgcLr',
        clientName: 'rayshop');
  }

  void _launchNaverLoginPage() async {
    const url = 'https://nid.naver.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '네이버 로그인 페이지를 열 수 없습니다.';
    }
  }

  //카카오는 로그인 페이지 까지 넘어가는데 갑자기 구글이 안되고 네이버도 안된다 ㅅㅂ. -> 취소 된당
  @override
  Widget build(BuildContext context) {
    void _onEmailLoginTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    //네이버
    void signInWithNaver() async {
      print("들왔냐");
      NaverLoginResult res = await FlutterNaverLogin.logIn();
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken req = await FlutterNaverLogin.currentAccessToken;

      if (result.status == NaverLoginStatus.loggedIn) {
        print('accessToken = ${result.accessToken}');
        print('id = ${result.account.id}');
        print('email = ${result.account.email}');
        print('name = ${result.account.name}');
      }
      _launchNaverLoginPage();
    }
    

    //카카오 로그인
    void signInWithKakao() async {
      kakaoLogin();
      print("카카오 로그인 들어옴");
      try {
        bool isInstalled = await isKakaoTalkInstalled();

        OAuthToken token = isInstalled
            ? await UserApi.instance.loginWithKakaoTalk()
            : await UserApi.instance.loginWithKakaoAccount();

        final url = Uri.https('kapi.kakao.com', '/v2/user/me');
         
        final response = await http.get(
          url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
          },
        );
        
        final profileInfo = json.decode(response.body);
        print(profileInfo.toString()+"카카오톡 로그인 정보를 알려줘");
        
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ));
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
      }
    }

    //구글 로그인
    Future<UserCredential> signInWithGoogle() async {
      // 구글 로그인 흐름 시작
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // 인증 세부 정보 가져오기
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // 새 자격 증명 만들기
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ));
      // 로그인 후 UserCredential 반환
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset("assets/character.png"),
            ),
            Column(
              children: [
                const DefaultTextStyle(
                  style: TextStyle(fontSize: 23, color: Colors.black),
                  child: Text.rich(
                    TextSpan(
                      text: '빛보다 빠른 거래',
                      children: <TextSpan>[
                        TextSpan(
                            text: ' 레이숍!',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Image.asset("assets/spectrum.png"),
              ],
            ),
            Gaps.v80,
            GestureDetector(
              onTap: signInWithNaver,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff2db400),
                  ),
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "네이버로 시작하기",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: signInWithKakao,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 241, 231, 42),
                  ),
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "카카오톡으로 시작하기",
                    style: TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: signInWithGoogle,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 249, 249, 251),
                  ),
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "구글로 시작하기",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _onEmailLoginTap,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3)),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColor,
                  ),
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "이메일로 시작하기",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Gaps.v20,
          ],
        ),
      ),
    ));
  }
}
