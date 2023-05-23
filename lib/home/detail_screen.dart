import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/enroll/widgets/enrollComboBox.dart';

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
  String timeRemaining = '';
  Timer? timer;
  late String productUid;
  late String curUid;
  late String curUserName;
  late String curBidderName;
  bool isSeller = false;
  late int curPrice;

  @override
  void initState() {
    super.initState();
    productUid = widget.data["uid"];
    curUid = FirebaseAuth.instance.currentUser?.uid ?? "";
    curUserName = FirebaseAuth.instance.currentUser?.displayName ?? "";
    curBidderName = widget.data["curBidder"];
    isSeller = (productUid == curUid);
    curPrice = widget.data['price'];
    subscribeToPriceUpdates();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      calculateTimeRemaining();
      print(isSeller);
    });
  }

  void calculateTimeRemaining() {
    DateTime currentTime = DateTime.now();
    Timestamp expirationTime = widget.data['expirationTime'];
    Duration difference = expirationTime.toDate().difference(currentTime);

    if (difference.isNegative) {
      setState(() {
        timeRemaining = 'Expired';
      });
      return;
    }

    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);
    if (minutes == 0 && seconds == 0) {
      setState(() {
        timeRemaining = '00:00';
      });
      timer?.cancel();
      return;
    }
    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = seconds.toString().padLeft(2, '0');

    setState(() {
      timeRemaining = '$minutesString:$secondsString';
    });
  }

  void _onBid() async {
    // Firestore 인스턴스 생성
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 콜렉션("product")에서 uid 필드가 'gZkIpQgPTUV6iVewNZzg9tdqkOF2'인 문서를 가져옴
    QuerySnapshot querySnapshot = await firestore
        .collection('products')
        .where('uid', isEqualTo: widget.data["uid"])
        .get();
    // 검색된 문서가 있는지 확인
    if (querySnapshot.docs.isNotEmpty) {
      // 첫 번째로 검색된 문서 가져오기
      QueryDocumentSnapshot docSnapshot = querySnapshot.docs.first;
      // 현재 가격 가져오기
      // 가격 증가
      int newPrice = curPrice + 5000;
      // 문서의 price 필드를 업데이트
      docSnapshot.reference.update({'price': newPrice});
      docSnapshot.reference.update({'curBidder': curUserName});
    } else {
      // 검색된 문서가 없을 경우에 대한 처리
      print('검색된 물품이 없습니다.');
    }
  }

  void subscribeToPriceUpdates() {
    // Firestore 인스턴스 생성
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 콜렉션("product")에서 uid 필드가 'gZkIpQgPTUV6iVewNZzg9tdqkOF2'인 문서를 구독
    Stream<QuerySnapshot> stream = firestore
        .collection('products')
        .where('uid', isEqualTo: widget.data["uid"])
        .snapshots();
    // 구독 시작
    stream.listen((QuerySnapshot querySnapshot) {
      // 검색된 문서들 중 첫 번째 문서 가져오기
      QueryDocumentSnapshot docSnapshot = querySnapshot.docs.first;
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      // 현재 가격 가져오기
      curPrice = data!['price'];
      curBidderName = data['curBidder'];
    });
  }

  int currentNaviIndex = 0;
  String selectedValue = '경쟁 입찰';
  List combobox = [
    '경쟁 입찰',
    '1',
  ];
  @override
  Widget build(BuildContext context) {
    String pricestr = widget.data['price'].toString();
    int price = int.parse(pricestr);
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
                      Text(
                        widget.data["productName"],
                        style: const TextStyle(
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
                        "$curPrice원~",
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  '입찰자 신청 마감 시간',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Gaps.v10,
                                Text(
                                  timeRemaining,
                                  style: const TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  '현재 입찰자',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  curBidderName,
                                  style: const TextStyle(
                                      fontSize: 28,
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
                  child: GestureDetector(
                    onTap: _onBid,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 50),
                        child: GestureDetector(
                          onTap: _onBid,
                          child: Text(
                            isSeller ? '수정하기' : "입찰하기",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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
