import 'package:flutter/material.dart';
import 'package:rayshop/auth/id_screen.dart';
import 'package:rayshop/auth/widgets/form_btn.dart';
import 'package:rayshop/constants/gaps.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _onLoginTap() {}
  void _onSignUpTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const IdScreen(),
      ),
    );
  }

  bool _isAlwaysLogin = false;
  void _isAlwaysLoginToggle(bool? newvalue) {
    setState(() {
      _isAlwaysLogin = !_isAlwaysLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: const [
                      Text(
                        "로그인을 부탁드려요!",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "E-mail",
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
                      hintText: "Password",
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
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: _isAlwaysLogin,
                        onChanged: _isAlwaysLoginToggle,
                      ),
                      const Text("로그인상태 유지")
                    ],
                  ),
                  Gaps.v32,
                  const FormButton(
                    isDisable: false,
                    text: "LOGIN",
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
          ],
        ),
      ),
    );
  }
}
