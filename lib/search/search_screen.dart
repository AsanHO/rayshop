import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> searchResults = [];

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
    });

    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('productName', isEqualTo: query)
        .get();

    setState(() {
      searchResults = snapshot.docs
          .map((doc) => doc.data()['productName'] as String)
          .toList();
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
                            onPressed: () {
                              setState(() {
                                recentSearches.clear();
                              });
                            },
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
                            return RecentSearch(text: text);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                return ListTile(
                  title: Text(searchResults[index]),
                  // Add other relevant widgets for displaying search results
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
