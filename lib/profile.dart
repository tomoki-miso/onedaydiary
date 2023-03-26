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
      backgroundColor: Color.fromARGB(255, 255, 226, 107),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: StreamBuilder<DocumentSnapshot>(
              // ここではDocumentSnapshotを使用して単一のドキュメントを取得する
              // QuerySnapshotを使用する必要はありません
              stream: FirebaseFirestore.instance
                  .collection("userInformation")
                  .doc(currentUser.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                // ドキュメントのデータをMap<String, dynamic>に変換
                Map<String, dynamic>? data =
                    snapshot.data?.data() as Map<String, dynamic>?;
                if (snapshot.connectionState == ConnectionState.waiting ||
                    data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 0),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset('assets/icon.png')),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/userInformation');
                              },
                              child: Text(
                                "編集",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 40, 40, 40)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '名前',
                                  ),
                                ],
                              ),
                            ), //名前
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ), //名前入力値
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '自己紹介',
                                  ),
                                ],
                              ),
                            ), //タブ
                            Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['note'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                            ), //自己紹介入力値
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            height: 200,
            width: 400,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                        axisNameWidget: Text(
                  "歩数の記録",
                  style: TextStyle(fontSize: 13),
                ))),
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
                      color: Color.fromARGB(255, 255, 226, 107))
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
