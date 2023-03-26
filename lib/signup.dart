import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'content.dart';
import 'post.dart';

class SignUpPage extends StatefulWidget {
  final String _uid;

  SignUpPage({required String uid}) : _uid = uid;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = '';
  String _password = '';
  String _displayName = '';

  final googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar:
    null;
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 10, width: 50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 255, 226, 107),
                  ),
                ),
                child: const Text('ユーザ登録',
                    style: TextStyle(color: Color.fromARGB(255, 40, 40, 40))),
                onPressed: () async {
                  try {
                    final UserCredential userCredential = await FirebaseAuth
                        .instance
                        .createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                    final User? user = userCredential.user;
                    if (user != null) {
                      print("ユーザ登録しました ${user.email} , ${user.uid}");
                    }
                    Navigator.pushNamed(context, '/completed');
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}