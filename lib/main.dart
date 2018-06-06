import 'package:flutter/material.dart';
import './utils/login_animator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NSALogin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Nunito'
      ),
      home: LoginAnimator(),
    );
  }
}