import 'package:flutter/material.dart';

class SignUpCompletedPage extends StatelessWidget {
  const SignUpCompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 241, 118),
        title: Text("登録完了画面",
            style: TextStyle(color: Color.fromARGB(255, 40, 40, 40))),
      ),
      body: Center(
          child: Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("登録完了！"),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 241, 118),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/content');
            },
            child: Text(
              "次へ",
              style: TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
            ),
          ),
        ]),
      )),
    );
  }
}
