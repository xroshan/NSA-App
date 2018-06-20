import 'package:flutter/material.dart';
import './utils/login_animator.dart';
import './pages/navigator.dart';

import 'components/profile/edit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NSALogin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueAccent, fontFamily: 'Nunito'),
      // home: NavigatorPage(),
      //home: LoginAnimator(),
      home: EditProfile(),
    );
  }
}
