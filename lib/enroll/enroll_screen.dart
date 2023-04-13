import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayshop/enroll/widgets/enrollComboBox.dart';
import 'package:rayshop/enroll/widgets/enrollTextField.dart';

class EnrollScreen extends StatefulWidget {
  const EnrollScreen({super.key});

  @override
  State<EnrollScreen> createState() => _EnrollScreenState();
}

class _EnrollScreenState extends State<EnrollScreen> {
  File? _image;
  Future _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final File imageFile = File(image.path);
    setState(() {
      _image = imageFile;
    });
  }

  final user = FirebaseAuth.instance.currentUser?.uid;
  String _name = "";
  String _price = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
        print(_name);
        print(user);
        //pw2컨트롤러 새로 만들기
      });
    });
    _priceController.addListener(() {
      setState(() {
        _price = _priceController.text;
        print(_price);
        //pw2컨트롤러 새로 만들기
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

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
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.infinity,
                    height: 200,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(_image!),
                          )
                        : const Icon(
                            Icons.camera_alt_outlined,
                            size: 70,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                EnrollTextField(
                  title: '제목',
                  showCheckbox: false,
                  controller: _nameController,
                ),
                const EnrollTextField(
                  title: '카테고리',
                  showCheckbox: false,
                ),
                EnrollTextField(
                  title: '가격',
                  showCheckbox: true,
                  controller: _priceController,
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
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
                      child: EnrollComboBox(
                          list: endDate, selectedValue: dateValue),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      width: 90,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                      child: EnrollComboBox(
                          list: endHour, selectedValue: hourValue),
                    ),
                    const Text(
                      "   후 마감",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                  child: EnrollComboBox(
                      list: auctionList, selectedValue: auctionValue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "상품 상세 설명 / ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "# 태그",
                        style: TextStyle(
                            color: Colors.white,
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
      ),
    );
  }
}
