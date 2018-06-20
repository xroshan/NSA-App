import 'package:flutter/material.dart';
import '../../utils/focus.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static final titleTextstyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white70,
    fontWeight: FontWeight.w500,
  );

  static final infoTextstyle =
      titleTextstyle.copyWith(fontWeight: FontWeight.w400);

  final _textControllerName = TextEditingController();
  final _textControllerMajor = TextEditingController();

  static FocusNode _focusNodeName = FocusNode();
  static FocusNode _focusNodeMajor = FocusNode();

  Widget _buildButtons(BuildContext context) {
    return Container(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(3.0)),
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile())),
              ))
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: new Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Text(
                  'Name:',
                  style: titleTextstyle,
                ),
              ),
              Expanded(
                child: Container(
                    child: EnsureVisibleWhenFocused(
                  focusNode: _focusNodeName,
                  child: TextField(
                    focusNode: _focusNodeName,
                    style: infoTextstyle,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Edit',
                        hintStyle: infoTextstyle.copyWith(
                            color: Colors.white.withOpacity(0.4))),
                    controller: _textControllerName,
                  ),
                )),
              )
            ],
          ),
          Divider(
            color: Colors.white30,
            indent: 2.0,
            height: 3.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/login2.webp'),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        width: 250.0,
                        margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.black45, width: 1.5)),
                        child: ClipOval(
                          child: Image.asset('assets/nsa_logo.jpg'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.black54),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () => print('change background'),
                              child: ListTile(
                                leading: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Change Background Image',
                                  style: titleTextstyle,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white70,
                              height: 1.0,
                            ),
                            InkWell(
                              onTap: () => print('change profile'),
                              child: ListTile(
                                leading: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Change Profile Picture',
                                  style: titleTextstyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                            _buildInfo(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildButtons(context)
            ],
          )),
    );
  }
}
