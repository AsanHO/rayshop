import 'package:flutter/material.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:rayshop/auth/main_auth.dart';
import 'package:rayshop/auth/widgets/form_btn.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/main_navigation/main_navigation_screen.dart';

class UserNameScreen extends StatefulWidget {
  final email;
  final pw;
  const UserNameScreen({super.key, this.email, this.pw});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  String _username = "";
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
      print(_username);
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  String? _isUsernameValid() {
    if (_username.isEmpty) return null;
    if (_username.length < 3) {
      return "3글자 이상 입력해주세요";
    }
    //이미 사용중인 아이디라면 리턴
    return null;
  }

  void _onSubmit() {
    if (_username.isEmpty || _isUsernameValid() != null) return;
    print(widget.email);
    print(widget.pw);
    AuthManage().createUser(widget.email, widget.pw, _username);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainAuthScreen(),
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
            Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "닉네임을 입력해주세요:)",
                    errorText: _isUsernameValid(),
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
                Gaps.v20,
              ],
            ),
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(
                  isDisable: _username.isEmpty || _isUsernameValid() != null),
            ),
          ],
        ),
      ),
    );
  }
}
