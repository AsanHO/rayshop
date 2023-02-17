import 'package:flutter/material.dart';
import 'package:rayshop/auth/username_screen.dart';
import 'package:rayshop/auth/widgets/form_btn.dart';
import 'package:rayshop/constants/gaps.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pw2Controller = TextEditingController();
  String _pw = "";
  String _pw2 = "";
  @override
  void initState() {
    super.initState();
    _pwController.addListener(() {
      setState(() {
        _pw = _pwController.text;

        //pw2컨트롤러 새로 만들기
      });
    });
    _pw2Controller.addListener(() {
      setState(() {
        _pw2 = _pw2Controller.text;

        //pw2컨트롤러 새로 만들기
      });
    });
  }

  @override
  void dispose() {
    _pwController.dispose();
    _pw2Controller.dispose();
    super.dispose();
  }

  String? _ispwValid() {
    if (_pw.isEmpty) return null;
    if (_pw.length < 6) {
      return "6글자 이상 입력해주세요";
    }
    //이미 사용중인 아이디라면 리턴
    return null;
  }

  String? _ispw2Valid() {
    if (_pw.isEmpty) return null;
    if (_pw != _pw2) {
      return "비밀번호가 일치하지 않습니다";
    }
    //이미 사용중인 아이디라면 리턴
    return null;
  }

  void _onSubmit() {
    if (_pw.isEmpty || _ispw2Valid() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserNameScreen(),
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
                  controller: _pwController,
                  decoration: InputDecoration(
                    hintText: "비밀번호를 입력해주세요:)",
                    errorText: _ispwValid(),
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
                TextField(
                  controller: _pw2Controller,
                  decoration: InputDecoration(
                    hintText: "비밀번호를 다시 한번 입력해주세요:)",
                    errorText: _ispw2Valid(),
                    helperText: "일치합니다",
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
              ],
            ),
            GestureDetector(
              onTap: _onSubmit,
              child:
                  FormButton(isDisable: _pw.isEmpty || _ispw2Valid() != null),
            ),
          ],
        ),
      ),
    );
  }
}
