import 'package:flutter/material.dart';

class SignUpCompletedPage extends StatelessWidget {
  const SignUpCompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登録完了画面"),
      ),
      body: Center(
          child: Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("登録完了！"),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/content');
              },
              child: Text("次へ"))
        ]),
      )),
    );
  }
}
