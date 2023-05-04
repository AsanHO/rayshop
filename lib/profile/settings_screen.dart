import 'package:flutter/material.dart';
import 'package:rayshop/profile/widgets/notication_settings_btn.dart';
import 'package:rayshop/profile/widgets/settings_button.dart';
import 'package:rayshop/auth/auth_fire.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rayshop/auth/main_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onLogout() async {
    AuthManage().signOut();
    print("로그아웃되었습니다.");
    const storage = FlutterSecureStorage();
    await storage.delete(key: "email");
    await storage.delete(key: "password");
    var email = await storage.read(key: "email");
    var pw = await storage.read(key: "password");
    print(email);
    print(pw);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainAuthScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.black,
          child: const Text(
            "설정",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10, color: Colors.grey.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "사용자 정보",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SettingsButton(
                    text: '배송지 설정',
                    onPressed: () {},
                  ),
                  SettingsButton(
                    text: '차단 계정 관리',
                    onPressed: () {},
                  ),
                  SettingsButton(
                    text: 'SNS 계정 연동',
                    onPressed: () {},
                  ),
                  SettingsButton(
                    text: '내 정보 수정',
                    onPressed: () {},
                  ),
                  SettingsButton(
                    text: '로그아웃',
                    onPressed: _onLogout,
                  ),
                ],
              ),
            ),
            Container(height: 10, color: Colors.grey.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '알림 설정',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  NoticationBtn(text: '방해 금지 시간 설정', showText: true),
                  NoticationBtn(text: '마케팅 알림', showText: false),
                  NoticationBtn(text: '채팅 알림', showText: false),
                  NoticationBtn(text: '경매 시작 전 알림', showText: false),
                ],
              ),
            ),
            Container(height: 10, color: Colors.grey.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "문의 / 신고",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SettingsButton(
                    text: '문의',
                    onPressed: () {},
                  ),
                  SettingsButton(
                    text: '오류 / 문제 신고하기',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(height: 10, color: Colors.grey.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "정보",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SettingsButton(
                    text: '이용 약관 및 정책',
                    onPressed: () {},
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
