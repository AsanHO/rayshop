import 'package:flutter/material.dart';
import 'package:rayshop/profile/widgets/settings_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "사용자 정보",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
            ),
            SettingsButton(text: '배송지 설정'),
            SizedBox(
              height: 15,
            ),
            SettingsButton(text: '차단 계정 관리'),
            SizedBox(
              height: 15,
            ),
            SettingsButton(text: 'SNS 계정 연동'),
            SizedBox(
              height: 15,
            ),
            SettingsButton(text: ' 내 정보 수정'),
            SizedBox(
              height: 15,
            ),
            Text(
              '알림 설정',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
