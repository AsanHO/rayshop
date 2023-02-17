import 'package:flutter/material.dart';
import 'package:rayshop/auth/pw_screen.dart';
import 'package:rayshop/auth/widgets/form_btn.dart';

class IdScreen extends StatefulWidget {
  const IdScreen({super.key});

  @override
  State<IdScreen> createState() => _IdScreenState();
}

class _IdScreenState extends State<IdScreen> {
  final TextEditingController _idController = TextEditingController();
  String _id = "";
  @override
  void initState() {
    super.initState();
    _idController.addListener(() {
      setState(() {
        _id = _idController.text;
        print(_id);
      });
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  String? _isIdValid() {
    if (_id.isEmpty) return null;
    if (_id.length < 6) {
      return "6글자 이상 입력해주세요";
    }
    //이미 사용중인 아이디라면 리턴
    return null;
  }

  void _onSubmit() {
    if (_id.isEmpty || _isIdValid() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
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
              controller: _idController,
              decoration: InputDecoration(
                hintText: "먼저 아이디가 필요해요:)",
                errorText: _isIdValid(),
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
              child: FormButton(isDisable: _id.isEmpty || _isIdValid() != null),
            ),
          ],
        ),
      ),
    );
  }
}
