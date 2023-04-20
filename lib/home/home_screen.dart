import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayshop/home/widgets/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
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
              onPressed: _onBellPressed,
              icon: const FaIcon(
                FontAwesomeIcons.solidBell,
                size: 30,
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/spectrum.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
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
                const SizedBox(
                  height: 25,
                ),
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
                const SizedBox(
                  height: 25,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: 15, // 원하는 항목 수로 설정
                  itemBuilder: (context, index) => Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 150,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
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
