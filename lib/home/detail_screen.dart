import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rayshop/constants/gaps.dart';
import 'package:rayshop/enroll/widgets/enrollComboBox.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final data;
  final imageUrl;
  final dataId;

  const DetailScreen({
    super.key,
    required this.data,
    required this.imageUrl,
    this.dataId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> opacityAnimation;
  String timeRemaining = '';
  Timer? timer;
  late String uid;
  late String curUid;
  late String curUserName;
  late String curBidderName;
  bool isSeller = false;
  late int curPrice;
  bool isEnd = false;
  late String postTime;

  @override
  void initState() {
    super.initState();
    uid = widget.data["uid"];
    curUid = FirebaseAuth.instance.currentUser?.uid ?? "";
    curUserName = FirebaseAuth.instance.currentUser?.displayName ?? "";
    curBidderName = widget.data["curBidder"];
    isSeller = (uid == curUid);
    curPrice = widget.data['price'];
    subscribeToPriceUpdates();
    startTimer();
    fetchPostTime();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  void fetchPostTime() async {
    Timestamp timestamp = widget.data['postTime'];
    DateTime dateTime = timestamp.toDate();
    postTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    controller.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      calculateTimeRemaining();
      print(uid);
      print(curUid);
    });
  }

  void calculateTimeRemaining() {
    DateTime currentTime = DateTime.now();
    Timestamp expirationTime = widget.data['expirationTime'];
    Duration difference = expirationTime.toDate().difference(currentTime);

    if (difference.isNegative) {
      setState(() {
        timeRemaining = 'Expired';
        isEnd = true;
      });
      return;
    }

    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);
    if (minutes == 0 && seconds == 0) {
      setState(() {
        timeRemaining = '00:00';
        isEnd = true;
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

  String getElapsedTime() {
    DateTime currentTime = DateTime.now();
    DateTime parsedTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(postTime);
    Duration diff = currentTime.difference(parsedTime);

    if (diff.inMinutes < 1) {
      return "방금 전";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}분 전";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}시간 전";
    } else {
      return DateFormat("MM월 dd일").format(parsedTime);
    }
  }

  void _onBid() async {
    // Firestore 인스턴스 생성
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('products').doc(widget.dataId);
    DocumentSnapshot docSnapshot = await documentRef.get();
    // 콜렉션("product")에서 uid 필드가 'gZkIpQgPTUV6iVewNZzg9tdqkOF2'인 문서를 가져옴
    // 검색된 문서가 있는지 확인
    controller.reset();
    controller.forward();
    if (docSnapshot.exists) {
      // 현재 가격 가져오기
      // 가격 증가
      int newPrice = curPrice + 5000;
      // 문서의 price 필드를 업데이트
      docSnapshot.reference.update({'price': newPrice});
      docSnapshot.reference.update({'curBidder': curUserName});
      await documentRef.update({
        'price': newPrice,
        'curUserName': curUserName,
      });
    } else {
      // 검색된 문서가 없을 경우에 대한 처리
      print('검색된 물품이 없습니다.');
    }
  }

  void subscribeToPriceUpdates() {
    // Firestore 인스턴스 생성
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 콜렉션("product")에서 uid 필드가 'gZkIpQgPTUV6iVewNZzg9tdqkOF2'인 문서를 구독
    Stream<DocumentSnapshot> stream =
        firestore.collection('products').doc(widget.dataId).snapshots();

    // 구독 시작
    stream.listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        // 현재 가격 가져오기
        curPrice = data!['price'];
        curBidderName = data['curBidder'];
      }
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
    String elapsedTime = postTime != null ? getElapsedTime() : "";
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
                      Expanded(
                        child: Text(
                          widget.data["productName"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        widget.data["category"],
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
                        "${NumberFormat('#,###').format(curPrice)}원~",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        elapsedTime,
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '입찰 마감 시간',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              isEnd ? "최종 입찰자" : '현재 입찰자',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Gaps.v14,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              timeRemaining,
                              style: const TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange),
                            ),
                            AnimatedBuilder(
                              animation: opacityAnimation,
                              builder: (BuildContext context, Widget? child) {
                                return Opacity(
                                  opacity: opacityAnimation.value,
                                  child: Text(
                                    curBidderName,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue),
                                  ),
                                );
                              },
                            )
                          ],
                        )
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
                  onTap: isEnd ? null : _onBid,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isEnd ? Colors.grey : Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 25),
                      child: Text(
                        isSeller ? '수정하기' : '입찰하기',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
