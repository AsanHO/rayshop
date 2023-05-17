import 'package:flutter/material.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/enroll/widgets/enrollComboBox.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final data;
  final imageUrl;
  const DetailScreen({
    super.key,
    required this.data,
    required this.imageUrl,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentNaviIndex = 0;
  String selectedValue = '경쟁 입찰';
  List combobox = [
    '경쟁 입찰',
    '1',
  ];
  @override
  Widget build(BuildContext context) {
    String pricestr = widget.data['price'];
    int price = int.parse(pricestr);
    final formatter = NumberFormat('#,###,###,###');
    final formattedPrice = formatter.format(price);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
            iconSize: 40,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
            iconSize: 40,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.data['imageUrl']),
            Image.asset(
              "assets/spectrum.png",
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '에어팟 프로',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '전자 / 디지털기기',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.4)),
                      ),
                    ],
                  ),
                  Gaps.v5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$formattedPrice원~",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '34분 전',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.4)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 150,
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '입찰자 신청 마감 시간',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Gaps.v10,
                                Text(
                                  '30:03',
                                  style: TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '현재 입찰자',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '3명',
                                  style: TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EnrollComboBox(
                              list: combobox, selectedValue: selectedValue),
                        ],
                      ),
                      Gaps.v20,
                      const Text(
                        '에어팟 프로\n\n(노이즈 캔슬링, 사운드, 마이크, 터치 등)\n\n가격은 최소 10만원부터 생각 중입니다.\n\n기타 문의는 연락주시면 답변 드리겠습니다.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Gaps.v40,
                      Wrap(
                        spacing: -5,
                        runSpacing: -20,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('#에어팟프로'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('#블루투스이어폰'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('#10만원'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('#에어팟프로10만원'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, -2)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 35,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                      child: Text(
                        '문의 게시판',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                      child: Text(
                        '수정하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
