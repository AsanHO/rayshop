import 'package:flutter/material.dart';
import 'package:rayshop/search/widgets/popular_search_button.dart';
import 'package:rayshop/search/widgets/recent_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size(0, 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.15),
                    width: screenWidth * 0.75,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "검색하세요!",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_sharp),
                    iconSize: 30,
                  )
                ],
              ),
              Image.asset(
                'assets/spectrum.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "인기 검색",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        PopularSearchButton(
                          text: "에어팟",
                        ),
                        PopularSearchButton(
                          text: "바지",
                        ),
                        PopularSearchButton(
                          text: "원피스",
                        ),
                        PopularSearchButton(
                          text: "갤럭시",
                        ),
                        PopularSearchButton(
                          text: "아이폰",
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "최근 검색",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "전체 삭제",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.4),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        child: Column(
                          children: const [
                            RecentSearch(text: "에어팟"),
                            RecentSearch(text: "갤럭시"),
                            RecentSearch(text: "아이폰"),
                            RecentSearch(text: "지갑"),
                            RecentSearch(text: "닌텐도"),
                          ],
                        ),
                      ),
                    ],
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
