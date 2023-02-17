import 'package:flutter/material.dart';
import 'package:rayshop/auth/login_screen.dart';
import 'package:rayshop/constants/gaps.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to RAYSHOP")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const DefaultTextStyle(
                style: TextStyle(fontSize: 23, color: Colors.black),
                child: Text.rich(
                  TextSpan(
                    text: '빛보다 빠른 거래',
                    children: <TextSpan>[
                      TextSpan(
                          text: ' 레이숍',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Image.asset("assets/spectrum.png"),
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
                      color: Colors.white),
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "구글로 시작하기",
                    style: TextStyle(color: Colors.black),
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
        ),
      ),
    );
  }
}
