import 'package:flutter/material.dart';
import '../pages/login.dart';

class LoginAnimator extends StatefulWidget {
  @override
  _LoginAnimatorState createState() => _LoginAnimatorState();
}

class _LoginAnimatorState extends State<LoginAnimator>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _controller.forward();
    _buttonController = AnimationController(
      vsync: this, duration: Duration(
        milliseconds: 3000
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _buttonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage(
      enterController: _controller,
      buttonController: _buttonController,
    );
  }
}
