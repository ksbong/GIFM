// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          AnimatedContainer(
              height: _showAppbar ? 100.0 : 0.0,
              duration: const Duration(microseconds: 200),
              child: SizedBox(
                  height: _showAppbar ? 30.0 : 0.0,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20, right: 180),
                    child: Text(
                      'G.I.F.M\n#어떤 게임의\n정보를 원하시나요?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ))),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                children: <Widget>[
                  buildCard('assets/images/lol.jpg', '[ League of Legends ]'),
                  buildCard('assets/images/valorant.jpg', '[ Valorant ]'),
                  buildCard('assets/images/overwatch.jpg', '[ Overwatch ]'),
                  buildCard('assets/images/pubg.jpg', '[ BattleGrounds ]'),
                  buildCard('assets/images/maplestory.jpg', '[ Maple Story ]')
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buildCard(String asset, String label) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: /*200*/ (MediaQuery.of(context).size.height) * 0.27 +
                MediaQuery.of(context).padding.top * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              asset,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: (MediaQuery.of(context).size.height) * 0.27 - 30, left: 10),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'GIFM',
                color: Colors.white),
          ),
        )
      ]),
    );
  }
}
