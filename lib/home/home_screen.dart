import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/home/detail_screen.dart';
import 'package:rayshop/home/notification_screen.dart';
import 'package:rayshop/home/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('products')
        .orderBy('postTime', descending: true)
        .snapshots();
  }

  void _onBellPressed() {}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _onBellPressed,
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _onBellPressed,
              icon: const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.solidBell,
                size: 30,
              ),
            )
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Gaps.v10,
                const Text(
                  '가볍고 빠른 거래 레이숍',
                  style: TextStyle(fontSize: 16),
                ),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: '지금 ',
                      ),
                      TextSpan(
                        text: '경매',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      TextSpan(
                        text: '를 시작해보세요!',
                      ),
                    ],
                  ),
                ),
                Gaps.v52,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: '인기상품',
                      icon: Icon(
                        Icons.star_rounded,
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                    Button(
                      text: '마감임박',
                      icon: Icon(
                        Icons.warning_rounded,
                        size: 50,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
                Gaps.v24,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: '찜',
                      icon: Icon(
                        Icons.favorite_rounded,
                        size: 50,
                        color: Colors.orange,
                      ),
                    ),
                    Button(
                      text: '추천',
                      icon: Icon(
                        Icons.thumb_up_rounded,
                        size: 50,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Gaps.v40,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '현재 인기 상승',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Gaps.v20,
                StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map;
                        print(data);
                        String documentId = docs[index].id; // 문서 ID 가져오기
                        String productName = data["productName"];
                        if (productName.length > 15) {
                          productName = "${productName.substring(0, 12)}...";
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  data: data,
                                  dataId: docs[index].id,
                                  imageUrl: data['imageUrl'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
<<<<<<< HEAD
                                AspectRatio(
                                  aspectRatio: 1, // 원하는 비율로 조정
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // 동그란 모서리를 원하는 크기로 조절할 수 있습니다.
                                    child: Image.network(
                                      data['imageUrl'] as String,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Gaps.v4,
=======
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // 원하는 둥글기 정도를 조절합니다.

                                  child: AspectRatio(
                                    aspectRatio: 1, // 원하는 비율로 조정
                                    child: Image.network(
                                      data["imageUrl"],
                                      fit: BoxFit
                                          .cover, // 이미지를 채우기 위해 fit: BoxFit.cover를 사용합니다.
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8), // 텍스트 위에 여백 추가
>>>>>>> origin/mj
                                Text(
                                  "${NumberFormat('#,###').format(data['price'])}원",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  productName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
