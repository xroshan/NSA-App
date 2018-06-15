import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'navigator.dart';
//import '../utils/focus.dart';       Uncomment if you want to use email and password for login

class LoginPage extends StatefulWidget {
  LoginPage(
      {@required AnimationController enterController,
      AnimationController buttonController})
      : enterAnimation = LoginEnterAnimation(enterController),
        buttonAnimation = ButtonAnimation(buttonController);

  final LoginEnterAnimation enterAnimation;
  final ButtonAnimation buttonAnimation;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var animationStatus = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*
  static FocusNode _focusNodeEmail = FocusNode();
  static FocusNode _focusNodePassword = FocusNode();
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  */

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Null> _signIn() async {
    widget.buttonAnimation.controller.forward();

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    print('User Name : ${user.displayName}');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NavigatorPage()));
  }

  Future<Null> _onTimeout() async {
    widget.buttonAnimation.controller.reverse();

    AlertDialog _dialog = AlertDialog(
      content: Text(
        'Check your network connectivity',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Ok',
            style: TextStyle(fontSize: 17.0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, child: _dialog);
    return null;
  }

  void _signOut() {
    googleSignIn.signOut();
    print('Sign out');
  }

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

/*
  final email = EnsureVisibleWhenFocused(
    focusNode: _focusNodeEmail,
    child: TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          fillColor: Colors.black54,
          border: OutlineInputBorder(),
          filled: true,
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.0),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.white)),
      controller: _emailController,
      focusNode: _focusNodeEmail,
    ),
  );

  final password = EnsureVisibleWhenFocused(
    focusNode: _focusNodePassword,
    child: TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 18.0),
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.black54,
        border: OutlineInputBorder(),
        filled: true,
        prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.0),
            child: const Icon(Icons.lock, color: Colors.white)),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.white),
      ),
      controller: _passwordController,
      focusNode: _focusNodePassword,
    ),
  );

  */

  Widget _buildButton(BuildContext context, Widget child) {
    return AnimatedBuilder(
      animation: widget.buttonAnimation.controller,
      builder: _buildButtonAnimation,
    );
  }

  Widget _buildButtonAnimation(BuildContext context, Widget child) {
    return new Padding(
      padding: widget.buttonAnimation.containerCircleAnimation.value,
      child: new InkWell(
          onTap: () {
            _signIn().timeout(Duration(seconds: 25), onTimeout: _onTimeout);
          },
          child: new Hero(
              tag: "fade",
              child: Container(
                  width: widget.buttonAnimation.buttonSqueezeanimation.value,
                  height: 55.0,
                  alignment: FractionalOffset.center,
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                  ),
                  child: widget.buttonAnimation.buttonSqueezeanimation.value >
                          210.0
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
                        )))),
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
            sigmaX: widget.enterAnimation.backdropBlur.value,
            sigmaY: widget.enterAnimation.backdropBlur.value,
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
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: _buildForm(context, child),
                ),
              ),
            ))),
      ],
    );
  }

  Widget _buildForm(BuildContext context, Widget child) {
    return AnimatedOpacity(
      opacity: widget.enterAnimation.opacity.value,
      duration: Duration(milliseconds: 500),
      child: Transform(
        transform: Matrix4.diagonal3Values(
            widget.enterAnimation.avatarSize.value,
            widget.enterAnimation.avatarSize.value,
            1.0),
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
      animation: widget.enterAnimation.controller,
      builder: _buildAnimation,
    );
  }
}

class ButtonAnimation {
  ButtonAnimation(this.controller)
      : buttonSqueezeanimation = new Tween(
          begin: 300.0,
          end: 70.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        buttomZoomOut = new Tween(
          begin: 70.0,
          end: 1000.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = new EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 50.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation<double> buttonSqueezeanimation;
  final Animation<double> buttomZoomOut;
}

class LoginEnterAnimation {
  LoginEnterAnimation(this.controller)
      : backdropBlur = new Tween(begin: 0.0, end: 3.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.400,
              1.000,
              curve: Curves.linear,
            ),
          ),
        ),
        avatarSize = new Tween(begin: 2.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.500,
              1.000,
              curve: Curves.ease,
            ),
          ),
        ),
        opacity = new Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Interval(0.500, 0.500)));

  final AnimationController controller;

  final Animation<double> backdropBlur;
  final Animation<double> avatarSize;
  final Animation<double> opacity;
}
