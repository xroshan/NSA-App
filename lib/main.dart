import 'package:flutter/material.dart';
import './pages/login/login.dart';
import './pages/navigator.dart';

import 'components/profile/edit.dart';

//main 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NSALogin',
      debugShowCheckedModeBanner: false,                        //does not show test banner at right side of screen
      theme: ThemeData(primaryColor: Colors.blueAccent, fontFamily: 'Nunito'),
      // home: NavigatorPage(),                         //just for testing different pages at begining
      home: LoginPage(),
      //home: EditProfile(),
    );
  }
}
