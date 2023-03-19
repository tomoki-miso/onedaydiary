import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'before_signup.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return BeforeSignUpPage();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("TL"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posts")
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
                  !data.containsKey('emotion') ||
                  !data.containsKey('content')) {
                return SizedBox.shrink();
              }
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Color.fromARGB(255, 146, 195, 235),
                    child: Column(
                      children: [
                        Text(data['emotion']),
                        Text(data['content']),
                      ],
                    ),
                  ),
                ],
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
