// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

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
          // 위에 글씨 부분
          AnimatedContainer(
            height: _showAppbar ? 100.0 : .0,
            duration: const Duration(microseconds: 300),
            child: SizedBox(
              height: _showAppbar ? 30.0 : .0,
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 5,
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 180),
                  child: Text(
                    'G.I.F.M\n#어떤 게임의\n정보를 원하시나요?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          // 스크롤 부분
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      // ignore: deprecated_member_use
                      launch(
                          'https://www.leagueoflegends.com/ko-kr/news/tags/patch-notes/')
                    },
                    child: buildCard(
                      'assets/images/lol.jpg',
                      '[ League of Legends ]',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      // ignore: deprecated_member_use
                      launch('https://playvalorant.com/ko-kr/news/')
                    },
                    child: buildCard(
                      'assets/images/valorant.jpg',
                      '[ VALORANT ]',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      // ignore: deprecated_member_use
                      launch(
                          'https://playoverwatch.com/ko-kr/news/patch-notes/live')
                    },
                    child: buildCard(
                      'assets/images/overwatch.jpg',
                      '[ OVERWATCH ]',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      // ignore: deprecated_member_use
                      launch(
                          'https://bbs.pubg.game.daum.net/gaia/do/pubg/update/list?bbsId=PN002&objCate1=255')
                    },
                    child: buildCard(
                      'assets/images/pubg.jpg',
                      '[ BATTLEGROUNDS ]',
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        // ignore: deprecated_member_use
                        {launch('https://maplestory.nexon.com/News/Update')},
                    child: buildCard(
                      'assets/images/maplestory.jpg',
                      '[ Maple Story ]',
                    ),
                  )
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
