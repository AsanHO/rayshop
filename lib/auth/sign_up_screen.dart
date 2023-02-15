import 'package:flutter/material.dart';
import 'package:rayshop/auth/id_screen.dart';
import 'package:rayshop/auth/widgets/form_btn.dart';
import 'package:rayshop/constants/gaps.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void _onLoginTap() {}
  void _onSignUpTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const IdScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to RAY SHOP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "ID",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Gaps.v16,
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "PASSWORD",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "아이디 찾기",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          VerticalDivider(
                            //이 위젯은 height라는 속성이 필요하기에, sizedBox로 부모 위젯을 감싸준다.
                            width: 20,
                            thickness: 0.5,
                            color: Colors.grey.shade500,
                            indent: 10, //여백
                            endIndent: 10,
                          ),
                          const Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          VerticalDivider(
                            //이 위젯은 height라는 속성이 필요하기에, sizedBox로 부모 위젯을 감싸준다.
                            width: 20,
                            thickness: 0.5,
                            color: Colors.grey.shade500,
                            indent: 10, //여백
                            endIndent: 10,
                          ),
                          GestureDetector(
                            onTap: _onSignUpTap,
                            child: const Text(
                              "회원가입",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Flexible(
                    child: FormButton(
                      isDisable: false,
                      text: "LOGIN",
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
