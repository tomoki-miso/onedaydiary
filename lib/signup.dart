import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'content.dart';
import 'post.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ユーザー名'),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
             
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  
                  hintText: 'walking-man',

                ),
              ),
            ),
             const Text('メールアドレス'),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
          
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixText: '@gmail.com'
                ),
              ),
            ),
             const Text('パスワード'),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
             
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  
                ),
              ),
            ),
             const Text('パスワード（確認）'),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
              
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                 
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 330,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/post');
                },
                child: const Text('登録'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
