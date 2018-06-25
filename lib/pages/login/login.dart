import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'animation.dart';

import '../../data/main_data.dart';
import '../navigator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LoginEnterAnimation enterAnimation;
  ButtonAnimation buttonAnimation;
  AnimationController _controller;
  AnimationController _buttonController;

  final logo = Container(
    height: 200.0,
    width: 200.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 3.0, color: Colors.black38)),
    padding: EdgeInsets.all(3.0),
    child: ClipOval(
      child: Image.asset('assets/nsa_logo.jpg'),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _controller.forward();
    _buttonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    enterAnimation = LoginEnterAnimation(_controller);
    buttonAnimation = ButtonAnimation(_buttonController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _buttonController.dispose();
  }

  void _login() async {
    _buttonController.forward();
    await login();
    _buttonController.reverse();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NavigatorPage()));
  }

  Widget _buildButton(BuildContext context, Widget child) {
    return AnimatedBuilder(
      animation: buttonAnimation.controller,
      builder: _buildButtonAnimation,
    );
  }

  Widget _buildButtonAnimation(BuildContext context, Widget child) {
    return new Padding(
      padding: buttonAnimation.containerCircleAnimation.value,
      child: new FlatButton(
          onPressed: _login,
          child: Container(
              width: buttonAnimation.buttonSqueezeanimation.value,
              height: 55.0,
              alignment: FractionalOffset.center,
              decoration: new BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(const Radius.circular(30.0)),
              ),
              child: buttonAnimation.buttonSqueezeanimation.value > 210.0
                  ? Text(
                      'LOGIN WITH GOOGLE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    )
                  : new CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ))),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login2.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: enterAnimation.backdropBlur.value,
            sigmaY: enterAnimation.backdropBlur.value,
          ),
          child: Container(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: true,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: _buildForm(context, child),
              ),
            ))),
      ],
    );
  }

  Widget _buildForm(BuildContext context, Widget child) {
    return AnimatedOpacity(
      opacity: enterAnimation.opacity.value,
      duration: Duration(milliseconds: 500),
      child: Transform(
        transform: Matrix4.diagonal3Values(enterAnimation.avatarSize.value,
            enterAnimation.avatarSize.value, 1.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: logo,
            ),
            SizedBox(
              height: 250.0,
            ),
            _buildButton(context, child),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: enterAnimation.controller,
      builder: _buildAnimation,
    );
  }
}
