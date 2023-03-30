import 'package:flutter/material.dart';
import 'package:rayshop/auth/pw_screen.dart';
import 'package:rayshop/auth/widgets/form_btn.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
        print(_email);
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final RegExp emailRegExp = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
      caseSensitive: false,
      multiLine: false,
    );
    if (!emailRegExp.hasMatch(_email)) {
      return "올바른 이메일 형식으로 입력해주세요";
    }
    return null;
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordScreen(email: _email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "먼저 이메일이 필요해요:)",
                errorText: _isEmailValid(),
                helperText: "사용할수 있습니다!",
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
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
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(
                  isDisable: _email.isEmpty || _isEmailValid() != null),
            ),
          ],
        ),
      ),
    );
  }
}
