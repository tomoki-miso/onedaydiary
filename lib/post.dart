import 'package:flutter/material.dart';


class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("投稿画面"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "今日しか覚えてないことを書いてみよう！",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
            ),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                maxLength: 140,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      '散歩してる人が赤信号の時に動き始めて大丈夫かな…と思ってたらはじめの一歩の時に青信号に変わった、奇跡の瞬間だった',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/content');
              }, 
              child: Text("投稿")
            )
          ],
        ),
      ),
    );
  }
}
