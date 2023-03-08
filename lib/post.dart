import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late TextEditingController _textEditingController;
  late String _emotion;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _emotion = 'うれしい';
  }

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
            const Text(
              "今日しか覚えてないことを書いてみよう！",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(
              width: double.infinity,
              height: 100,
            ),
            DropdownButton(
              items: const [
                DropdownMenuItem(
                  value: 'うれしい',
                  child: Text('うれしい'),
                ),
                DropdownMenuItem(
                  value: 'かなしい',
                  child: Text('かなしい'),
                ),
                DropdownMenuItem(
                  value: 'たのしい',
                  child: Text('たのしい'),
                ),
                DropdownMenuItem(
                  value: 'おどろき',
                  child: Text('おどろき'),
                ),
                DropdownMenuItem(
                  value: 'なつかしい',
                  child: Text('なつかしい'),
                ),
                DropdownMenuItem(
                  value: 'そのほか',
                  child: Text('そのほか'),
                ),
              ],
              value: _emotion,
              onChanged: (String? value) {
                setState(() {
                  _emotion = value!;
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: _textEditingController,
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
                  _onFieldSubmitted();
                  Navigator.pushNamed(context, '/content');
                },
                child: const Text("投稿")),
          ],
        ),
      ),
    );
  }

  void _onFieldSubmitted() {
    final content = _textEditingController.text.trim();
    if (content.isEmpty) {
      return;
    }
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    posts.add({
      "content": content,
      "emotion": _emotion,
      "createdAt": FieldValue.serverTimestamp(),
    });

    _textEditingController.clear();
    setState(() {
      _emotion = 'うれしい';
    });
  }
}
