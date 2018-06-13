import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'navigator.dart';
//import '../utils/focus.dart';       Uncomment if you want to use email and password for login

class LoginPage extends StatefulWidget {
  LoginPage({@required AnimationController controller})
      : animation = LoginEnterAnimation(controller);

  final LoginEnterAnimation animation;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*
  static FocusNode _focusNodeEmail = FocusNode();
  static FocusNode _focusNodePassword = FocusNode();
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  */

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isAuthenticating = false;

  Future<Null> _signIn() async {
    setState(() {
      _isAuthenticating = true;
    });
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    print('User Name : ${user.displayName}');

    setState(() {
      _isAuthenticating = false;
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NavigatorPage()));
  }

  Future<Null> _onTimeout() {
    setState(() {
      _isAuthenticating = false;
    });
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
    print('failed');
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

  Widget _buildLoginWithGoogle(BuildContext context, Widget child) {
    return RaisedButton(
        elevation: 20.0,
        shape:
            StadiumBorder(side: BorderSide(color: Colors.white70, width: 1.5)),
        color: Colors.blueAccent,
        child: Container(
          height: 50.0,
          width: 250.0,
          child: Center(
            child: Text(
              'LOGIN WITH GOOGLE',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onPressed: () {
          _signIn().timeout(Duration(seconds: 25), onTimeout: _onTimeout);
        });
  }

  Widget _buildLoginWithFacebook(BuildContext context, Widget child) {
    return RaisedButton(
      elevation: 8.0,
      shape: StadiumBorder(side: BorderSide(color: Colors.white70, width: 1.5)),
      color: Colors.redAccent,
      child: Container(
        height: 50.0,
        width: 250.0,
        child: Center(
          child: Text(
            'LOGIN WITH FACEBOOK',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
      onPressed: () => _signOut(),
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
            sigmaX: widget.animation.backdropBlur.value,
            sigmaY: widget.animation.backdropBlur.value,
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
        _isAuthenticating
            ? Center(
                child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
                child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Center(child: new CircularProgressIndicator())),
              ))
            : new Container()
      ],
    );
  }

  Widget _buildForm(BuildContext context, Widget child) {
    return AnimatedOpacity(
      opacity: widget.animation.opacity.value,
      duration: Duration(milliseconds: 500),
      child: Transform(
        transform: Matrix4.diagonal3Values(widget.animation.avatarSize.value,
            widget.animation.avatarSize.value, 1.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: logo,
            ),
            SizedBox(
              height: 150.0,
            ),
            _buildLoginWithGoogle(context, child),
            SizedBox(
              height: 40.0,
            ),
            _buildLoginWithFacebook(context, child)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation.controller,
      builder: _buildAnimation,
    );
  }
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
