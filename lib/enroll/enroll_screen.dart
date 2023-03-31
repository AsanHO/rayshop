import 'package:flutter/material.dart';
import 'package:rayshop/enroll/widgets/enrollComboBox.dart';
import 'package:rayshop/enroll/widgets/enrollTextField.dart';

class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  List personNumber = [
    '제한없음',
    '2명',
    '3명',
    '4명',
    '5명',
    '6명',
    '7명',
    '8명',
    '9명',
    '10명'
  ];

  List endDate = [
    '날짜',
    '1일',
    '2일',
    '3일',
    '4일',
    '5일',
    '6일',
    '7일',
  ];

  List endHour = [
    '시간',
    '1시간',
    '2시간',
    '3시간',
    '4시간',
    '5시간',
    '6시간',
  ];

  List auctionList = ['경매 종류'];

  String auctionValue = '경매 종류';
  String dateValue = '날짜';
  String hourValue = '시간';
  String personNumberValue = '제한없음';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  height: 110,
                  width: 110,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 70,
                        ),
                        Text(
                          '0/10',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const EnrollTextField(
                title: '제목',
                showCheckbox: false,
              ),
              const EnrollTextField(
                title: '카테고리',
                showCheckbox: false,
              ),
              const EnrollTextField(
                title: '가격',
                showCheckbox: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "최대 입찰 인원 수",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                    child: EnrollComboBox(
                        list: personNumber, selectedValue: personNumberValue),
                  ),
                  const Text(
                    "   명",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "입찰 신청 마감일",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 90,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                    child:
                        EnrollComboBox(list: endDate, selectedValue: dateValue),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 90,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                    child:
                        EnrollComboBox(list: endHour, selectedValue: hourValue),
                  ),
                  const Text(
                    "   후 마감",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "경매 종류",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 110,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                child: EnrollComboBox(
                    list: auctionList, selectedValue: auctionValue),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "상품 상세 설명 / ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "# 태그",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
