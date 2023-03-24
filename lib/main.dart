import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_flutter/before_signup.dart';
import 'package:test_flutter/demo.dart';
import 'firebase_options.dart';
import 'content.dart';
import 'post.dart';
import 'signup.dart';
import 'signup_completed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'profile.dart';
import 'signup.dart';
import 'signin.dart';
import 'demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 初回起動時のみデモページを開く
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  Widget homeScreen = isFirstTime ? const DemoPage() : const MyStatefulWidget();
  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
  }

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(homeScreen: homeScreen));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;

  const MyApp({Key? key, required this.homeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = MaterialColor(
      0xFFFFE26B,
      <int, Color>{
        50: Color(0xFFFFE26B),
        100: Color(0xFFFFE26B),
        200: Color(0xFFFFE26B),
        300: Color(0xFFFFE26B),
        400: Color(0xFFFFE26B),
        500: Color(0xFFFFE26B),
        600: Color(0xFFFFE26B),
        700: Color(0xFFFFE26B),
        800: Color(0xFFFFE26B),
        900: Color(0xFFFFE26B),
      },
    );
    //色指定
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: homeScreen,
      routes: {
        '/post': (context) => PostPage(),
        '/content': (context) => ContentPage(),
        '/completed': (context) => SignUpCompletedPage(),
        '/beforesignup': (context) => BeforeSignUpPage(),
        '/signup': (context) => SignUpPage(uid: 'example_uid'),
        '/signin': (context) => const SignInPage(),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static final _screens = [
    ContentPage(),
    const PostPage(),
    const ProfilePage(),
  ];

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'タイムライン'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: '作成'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
