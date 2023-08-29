import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/home/detail_screen.dart';
import 'package:rayshop/search/widgets/popular_search_button.dart';
import 'package:rayshop/search/widgets/recent_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  List<DocumentSnapshot> searchResults = []; // Update this type
  bool showSearchResults =
      false; // Flag to control visibility of search results

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearRecentSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  void search(String query) async {
    setState(() {
      recentSearches.add(query);
      showSearchResults = true; // Set flag to true when search is performed
    });

    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('productName', isEqualTo: query)
        .get();

    setState(() {
      searchResults = snapshot.docs;
    });
  }

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.15),
                    width: screenWidth * 0.75,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (value) {
                        search(value);
                      },
                      decoration: const InputDecoration(
                        hintText: "검색하세요!",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      search(_searchController.text);
                    },
                    icon: const Icon(Icons.search_sharp),
                    iconSize: 30,
                  ),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                          TextButton(
                            onPressed: () {},
                            child: TextButton(
                              onPressed: _clearRecentSearches,
                              child: Text(
                                "전체 삭제",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 12),
                        child: Column(
                          children: recentSearches.map((text) {
                            return RecentSearch(
                              text: text,
                              recentSearches: recentSearches,
                              onDelete: () {
                                setState(() {
                                  recentSearches.remove(text);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showSearchResults) // Show this section if showSearchResults is true
              Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "검색 결과",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          searchResults[index].data() as Map<String, dynamic>;
                      final productName = data['productName'] as String;
                      final price = data['price'] as int;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                data: data,
                                dataId: searchResults[index].id,
                                imageUrl: data['imageUrl'] as String,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.2)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 100, // 이미지의 가로 크기
                                    height: 100, // 이미지의 세로 크기
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        data['imageUrl'] as String,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        productName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Gaps.v10,
                                      Text(
                                        "${NumberFormat('#,###').format(price)}원",
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
