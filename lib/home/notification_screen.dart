import 'package:flutter/material.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/home/widgets/noti_category.dart';
import 'package:rayshop/home/widgets/noti_list.dart';
import 'package:rayshop/profile/settings_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '알림',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
            iconSize: 40,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Image.asset(
            "assets/spectrum.png",
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NotiCategory(text: '전체'),
                NotiCategory(text: '진행 예정'),
                NotiCategory(text: '판매 경매'),
                NotiCategory(text: '구매 경매'),
              ],
            ),
            Gaps.v32,
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  NotiList(
                    text: '00:30:23 뒤에 "블루투스 이어폰" 경매가 시작됩니다.',
                    daybefore: '1일전',
                    icon: Icon(
                      Icons.notifications,
                      size: 35,
                    ),
                  ),
                  Gaps.v40,
                  NotiList(
                    text: '내일(2023/3/17) "중고 신발" 경매가 시작됩니다.',
                    daybefore: '1일전',
                    icon: Icon(
                      Icons.notifications,
                      size: 35,
                    ),
                  ),
                  Gaps.v40,
                  NotiList(
                    text: '경매에 도전해 보시는 건 어떠세요?',
                    daybefore: '2일전',
                    icon: Icon(
                      Icons.question_mark,
                      size: 35,
                    ),
                  ),
                  Gaps.v40,
                  NotiList(
                    text: '찜하신 "신발" 경매 입찰가가 내려갔어요!',
                    daybefore: '2일전',
                    icon: Icon(
                      Icons.priority_high,
                      size: 35,
                    ),
                  ),
                  Gaps.v40,
                  NotiList(
                    text: '찜하신 "가방" 경매 입찰가가 내려갔어요!',
                    daybefore: '3일전',
                    icon: Icon(
                      Icons.priority_high,
                      size: 35,
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
