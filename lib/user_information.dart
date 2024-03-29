import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final TextEditingController _textContName = TextEditingController();
  final TextEditingController _textContProf = TextEditingController();
  String _editTextName = '';
  String _editTextProf = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('ユーザー登録'),
        /*actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: OutlinedButton(
              child: const Text(
                '保存',
                style: TextStyle(color: Colors.white)
              ),
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                Map<String, dynamic> insertObj = {
                    'id': user!.uid,
                    'name': _textContName.text,
                    'note': _textContProf.text,
                    'vaild': true,
                    'created_at': FieldValue.serverTimestamp(),
                    'modified_at': FieldValue.serverTimestamp()
                  };
                try {
                  var doc = await FirebaseFirestore.instance.collection('userInformation').doc(user.uid);
                  await doc.set(insertObj);
		  Navigator.pop(context);
                } catch ( e ) {
                  print('-----insert error----');
                  print(e);
                }
              }, 
            )
          )
        ],*/
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomSpace),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.grey))),
                      child: Row(
                        // 名前
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, right: 40.0),
                            child: Text('名前'),
                          ),
                          Flexible(
                            child: TextField(
                              autofocus: false,
                              controller: _textContName,
                              maxLines: 1,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (String? val) {
                                if (val != null && val != '') {
                                  _editTextName = val;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.grey))),
                      child: Row(
                        // 自己紹介
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, right: 40.0),
                            child: Text('自己紹介'),
                          ),
                          Flexible(
                            child: TextField(
                              autofocus: false,
                              controller: _textContProf,
                              maxLines: 2,
                              minLines: 1,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (String? val) {
                                if (val != null && val != '') {
                                  _editTextProf = val;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 251, 215),
                        ),
                      ),
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        Map<String, dynamic> insertObj = {
                          'id': user!.uid,
                          'name': _textContName.text,
                          'note': _textContProf.text,
                          'vaild': true,
                          'created_at': FieldValue.serverTimestamp(),
                          'modified_at': FieldValue.serverTimestamp()
                        };
                        try {
                          var doc = await FirebaseFirestore.instance
                              .collection('userInformation')
                              .doc(user.uid);
                          await doc.set(insertObj);
                          Navigator.pop(context);
                        } catch (e) {
                          print('-----insert error----');
                          print(e);
                        }
                      },
                      child: const Text(
                        "保存",
                        style:
                            TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
