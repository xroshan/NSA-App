import 'package:flutter/material.dart';

import '../../utils/focus.dart';

import '../../data/main_data.dart';

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

  final _textControllerDisplayName = TextEditingController();
  final _textControllerSex = TextEditingController();
  final _textControllerDOB = TextEditingController();
  final _textControllerClassification = TextEditingController();
  final _textControllerMajor = TextEditingController();
  final _textControllerHometown = TextEditingController();
  final _textControllerCurrentAddress = TextEditingController();
  final _textControllerContactNumber = TextEditingController();
  final _textControllerBio = TextEditingController();

  static FocusNode _focusNodeDisplayName = FocusNode();
  static FocusNode _focusNodeSex = FocusNode();
  static FocusNode _focusNodeDOB = FocusNode();
  static FocusNode _focusNodeClassification = FocusNode();
  static FocusNode _focusNodeMajor = FocusNode();
  static FocusNode _focusNodeHometown = FocusNode();
  static FocusNode _focusNodeCurrentAddress = FocusNode();
  static FocusNode _focusNodeContactNumber = FocusNode();
  static FocusNode _focusNodeBio = FocusNode();

  @override
  void initState() {
    super.initState();
    if (userPerson != null) {
      _textControllerDisplayName.text = userPerson.displayName;
      _textControllerSex.text = userPerson.sex;
      _textControllerDOB.text = userPerson.dob;
      _textControllerHometown.text = userPerson.hometown;
      _textControllerCurrentAddress.text = userPerson.currentAddress;
      _textControllerContactNumber.text = userPerson.contactNumber;
      _textControllerMajor.text = userPerson.major;
      _textControllerClassification.text = userPerson.classification;
      _textControllerBio.text = userPerson.bio;
    }
  }

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
                  onPressed: () {
                    _applyChanges();
                    Navigator.pop(context);
                  }))
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, String title,
      TextEditingController textController, FocusNode node) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: new Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 120.0,
                child: Text(
                  title,
                  style: titleTextstyle,
                ),
              ),
              Expanded(
                child: Container(
                    child: EnsureVisibleWhenFocused(
                  focusNode: node,
                  child: TextField(
                    focusNode: node,
                    style: infoTextstyle,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Edit',
                        hintStyle: infoTextstyle.copyWith(
                            color: Colors.white.withOpacity(0.4))),
                    controller: textController,
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

  void _applyChanges() async {
    userPerson.displayName = _textControllerDisplayName.text;
    userPerson.sex = _textControllerSex.text;
    userPerson.dob = _textControllerDOB.text;
    userPerson.hometown = _textControllerHometown.text;
    userPerson.currentAddress = _textControllerCurrentAddress.text;
    userPerson.contactNumber = _textControllerContactNumber.text;
    userPerson.major = _textControllerMajor.text;
    userPerson.classification = _textControllerClassification.text;
    userPerson.bio = _textControllerBio.text;

    await updateUserRecord();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login2.webp'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: new Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        width: 250.0,
                        margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black45, width: 1.5)),
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
                            _buildInfo(
                                context,
                                'Full Name',
                                _textControllerDisplayName,
                                _focusNodeDisplayName),
                            _buildInfo(context, 'Sex', _textControllerSex,
                                _focusNodeSex),
                            _buildInfo(context, 'DOB', _textControllerDOB,
                                _focusNodeDOB),
                            _buildInfo(context, 'Hometown',
                                _textControllerHometown, _focusNodeHometown),
                            _buildInfo(
                                context,
                                'Current Address',
                                _textControllerCurrentAddress,
                                _focusNodeCurrentAddress),
                            _buildInfo(
                                context,
                                'Contact Number',
                                _textControllerContactNumber,
                                _focusNodeContactNumber),
                            _buildInfo(context, 'Major', _textControllerMajor,
                                _focusNodeMajor),
                            _buildInfo(
                                context,
                                'Classification',
                                _textControllerClassification,
                                _focusNodeClassification),
                            _buildInfo(context, 'Bio', _textControllerBio,
                                _focusNodeBio),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _buildButtons(context)
              ],
            )),
      ),
    );
  }
}
