import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'content.dart';
import 'post.dart';
import 'signup.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();


  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: {

        '/post': (context) => PostPage(),
        '/content': (context) => ContentPage(),
      },
    );
  }
}

