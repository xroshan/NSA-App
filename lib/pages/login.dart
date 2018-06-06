import 'package:flutter/material.dart';
import '../utils/focus.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static FocusNode _focusNodeEmail = FocusNode();
  static FocusNode _focusNodePassword = FocusNode();
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

  final logo = Container(
    height: 200.0,
    width: 200.0,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/nsa_logo.jpg'), fit: BoxFit.fill),
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: Colors.black)),
  );

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
        border: const OutlineInputBorder(),
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

  final loginBtn = RaisedButton(
    elevation: 20.0,
    shape: StadiumBorder(),
    color: Colors.blueAccent,
    child: Container(
      height: 40.0,
      width: 140.0,
      child: Center(
        child: Text(
          'LOGIN',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
    onPressed: () => print('Login was pressed!'),
  );

  final registerBtn = RaisedButton(
    elevation: 20.0,
    shape: StadiumBorder(),
    color: Colors.redAccent,
    child: Container(
      height: 40.0,
      width: 140.0,
      child: Center(
        child: Text(
          'REGISTER',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
    onPressed: () => print('Register was pressed!'),
  );

  @override
  Widget build(BuildContext context) {
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
        Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: true,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: logo,
                      ),
                      SizedBox(
                        height: 90.0,
                      ),
                      email,
                      SizedBox(
                        height: 15.0,
                      ),
                      password,
                      SizedBox(
                        height: 50.0,
                      ),
                      loginBtn,
                      SizedBox(
                        height: 15.0,
                      ),
                      registerBtn
                    ],
                  ),
                ),
              ),
            ))),
      ],
    );
  }
}
