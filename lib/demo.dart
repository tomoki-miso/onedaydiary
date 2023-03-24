import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);
  final String title = "Demo Page";

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final GlobalKey<ScaffoldMessengerState> _globalKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // when user select SKIP
          Navigator.pushNamed(context, '/beforesignup');
        },
        finishCallback: () {
          // when user select NEXT
         Navigator.pushNamed(context, '/beforesignup');
        },
      ),
    );
  }


  final pages = [
    PageModel.withChild(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                alignment: Alignment(-0.7, 0),
                child: const Text(
                  "こんにちは！\n「さんぽぽ」は、",
                  style: TextStyle(fontSize: 25),
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment(0.2, 0),
              child: const Text(
                "明日になったら忘れてしまうかもしれない、\n印象に残った今日のことを記録するアプリ",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment(0.85, 0.3),
              child: const Text(
                "です",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Image.asset(
              'assets/icon.png',
              height: 300,
            )
          ],
        ),
        color: Color.fromARGB(255, 255, 226, 107),
        doAnimateChild: true),
    PageModel.withChild(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 70,
            ),
            Container(
                alignment: Alignment(-0.4, 0.6),
                child: const Text(
                  "今日歩いた歩数の分だけ、",
                  style: TextStyle(fontSize: 25),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment(-0.5, 0),
              child: const Text(
                "今日見た景色や、\n面白かった出来事\n\n友だちとは話さない、\n個人的に盛り上がったこと",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment(0.7, 0.5),
              child: const Text(
                "を記録できます！",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
        color: Color.fromARGB(255, 255, 226, 107),
        doAnimateChild: true),
  ];
}
