import 'package:flutter/material.dart';
import '../pages/login.dart';

class LoginAnimator extends StatefulWidget {
  @override
  _LoginAnimatorState createState() => _LoginAnimatorState();
}

class _LoginAnimatorState extends State<LoginAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage(
      controller: _controller,
    );
  }
}
