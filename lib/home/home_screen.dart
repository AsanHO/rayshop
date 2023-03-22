import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        body: TabBarView(children: [
          Column(
            children: [
              Row(
                children: const [Text("인기상품")],
              )
            ],
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 9 / 16),
            itemBuilder: (context, index) => Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      color: Colors.amber,
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
