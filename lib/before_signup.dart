import 'package:flutter/material.dart';

class BeforeSignUpPage extends StatelessWidget {
  const BeforeSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ログインまたは新規登録"),
      ),
      body: Center(
        child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
            ElevatedButton(onPressed:(){
               Navigator.pushNamed(context, '/signup');
            },
             child: Text("新規登録")
             ),
             ElevatedButton(onPressed:(){
               Navigator.pushNamed(context, '/signin');
            },
             child: Text("ログイン")
             ),
           ],
        ),
      ),
    );
  }
}