import 'package:flutter/material.dart';
import 'package:rayshop/auth/login_screen.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rayshop/main_navigation/main_navigation_screen.dart';

class MainAuthScreen extends StatelessWidget {
  const MainAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _onEmailLoginTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

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
      appBar: AppBar(title: const Text("Welcome to RAYSHOP")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Gaps.v120,
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
              Column(
                children: [
                  FractionallySizedBox(
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
                          color: const Color(0xff2db400)),
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        "네이버로 시작하기",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Gaps.v20,
                  FractionallySizedBox(
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
                        color: const Color(0xfff9e000),
                      ),
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        "카카오로 시작하기",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Gaps.v20,
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
                          color: Color.fromARGB(255, 249, 249, 251),
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
                  Gaps.v20,
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
            ],
          ),
        ),
      ),
    );
  }
}
