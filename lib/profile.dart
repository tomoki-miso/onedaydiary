import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter/before_signup.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'signup.dart';

class ProfilePage extends StatelessWidget {
  
  const ProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // ログインしていない場合はログイン画面に遷移
      return BeforeSignUpPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("MYTL"),
      ),
      body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection("user")
     .doc(currentUser.uid)
      .collection("userPosts")
      .orderBy('createdAt', descending: true)
      .snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic>? data =
            snapshot.data!.docs[index].data() as Map<String, dynamic>?;
        if (data == null ||
            !data.containsKey('content')) {
          return SizedBox.shrink();
        }
        return Container(
          color: Color.fromARGB(255, 146, 195, 235),
          child: Column(
            children: [
              Text(data['content']),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount: snapshot.data!.docs.length,
    );
  },
),
    );
  }
}
final uid = FirebaseAuth.instance.currentUser!.uid;
