import 'package:flutter/material.dart';

class BeforeSignUpPage extends StatelessWidget {
  const BeforeSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: null,
      appBar: AppBar(
          title: Text(
            "ログインまたは新規登録",
            style: TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 241, 118)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 241, 118),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                "新規登録",
                style: TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 255, 241, 118),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: Text(
                  "ログイン",
                  style: TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
                )),
          ],
        ),
      ),
    );
  }
}
