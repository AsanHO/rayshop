import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayshop/chats/chats_screen.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/constants/sizes.dart';
import 'package:rayshop/enroll/enroll_screen.dart';
import 'package:rayshop/home/home_screen.dart';
import 'package:rayshop/main_navigation/widgets/nav_btn.dart';
import 'package:rayshop/profile/profile_screen.dart';
import 'package:rayshop/search/search_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  void _onPostVideoBtnTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("비디오 녹화")),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //회원가입에는 필요할지몰라도, 영상코멘트 댓글등에선 불필요함 반드시 scaffold에서 운영하는 코드
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const EnrollScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ChatScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const ProfileScreen(),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10, horizontal: Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBtn(
                text: "홈",
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                isSelected: _selectedIndex == 0,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(0),
              ),
              NavBtn(
                text: "검색",
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              NavBtn(
                text: "등록",
                icon: FontAwesomeIcons.plus,
                selectedIcon: FontAwesomeIcons.plus,
                isSelected: _selectedIndex == 2,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(2),
              ),
              Gaps.h24,
              NavBtn(
                text: "채팅",
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(3),
              ),
              NavBtn(
                text: "내계정",
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
