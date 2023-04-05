import 'package:flutter/material.dart';
import 'package:rayshop/chats/widgets/chat_category.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "경매 채팅",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_sharp),
            iconSize: 40,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            iconSize: 40,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(0, 15),
          child: Image.asset(
            'assets/spectrum.png',
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChatCategory(text: '전체'),
                ChatCategory(text: '진행중'),
                ChatCategory(text: '진행 예정'),
                ChatCategory(text: '판매 경매'),
                ChatCategory(text: '구매 경매'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
