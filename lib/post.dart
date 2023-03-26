import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'before_signup.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return BeforeSignUpPage();
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 226, 107),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "今日しか覚えてなさそうなこと",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 40, 40, 40)),
            ),
            const SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
                //複数行テキストボックス
                maxLines: null,
                keyboardType: TextInputType.multiline,

                controller: _textEditingController,
                maxLength: 140,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText:
                      '散歩してる人が赤信号の時に動き始めて大丈夫かな…と思ってたらはじめの一歩の時に青信号に変わった、奇跡の瞬間だった',
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 255, 251, 215),
                ),
              ),
              onPressed: () {
                _onFieldSubmitted(user);
                Navigator.pushNamed(context, '/content');
              },
              child: const Text(
                "投稿",
                style: TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFieldSubmitted(User user) {
    final content = _textEditingController.text.trim();
    if (content.isEmpty) {
      return;
    }
    CollectionReference userPosts = FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('userPosts');
    userPosts.add({
      "content": content,
      "createdAt": FieldValue.serverTimestamp(),
    });
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    posts.add({
      "content": content,
      "createdAt": FieldValue.serverTimestamp(),
      "userId": user.uid,
    });
  }
}
