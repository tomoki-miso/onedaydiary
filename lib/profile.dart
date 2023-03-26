import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter/before_signup.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'signup.dart';
import 'package:fl_chart/fl_chart.dart';

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
      backgroundColor: const Color.fromARGB(255, 255, 226, 107),
      appBar: AppBar(
        title: Text("アカウントと記録",
            style: TextStyle(color: Color.fromARGB(255, 40, 40, 40))),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            color: Colors.white,
            height: 200,
            width: 400,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: [
                        FlSpot(0, 100),
                        FlSpot(1, 1000),
                        FlSpot(2, 3000),
                        FlSpot(3, 500),
                        FlSpot(4, 400),
                        FlSpot(5, 2500),
                        FlSpot(6, 10000),
                        FlSpot(7, 2909),
                        FlSpot(8, 376),
                        FlSpot(9, 290),
                        FlSpot(10, 6666),
                      ],
                      isCurved: true,
                      barWidth: 2,
                      color: const Color.fromARGB(255, 255, 226, 107)),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(currentUser.uid)
                  .collection("userPosts")
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic>? data = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>?;
                    if (data == null || !data.containsKey('content')) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 3.0),
                      //できれば％で指定したい
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      color: Color.fromARGB(255, 255, 255, 255),
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
          ),
        ],
      ),
    );
  }
}

final uid = FirebaseAuth.instance.currentUser!.uid;
