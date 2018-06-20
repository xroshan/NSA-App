import 'package:flutter/material.dart';
import 'edit.dart';

class ProfileView extends StatelessWidget {
  var isMyProfile = false;

  final titleTextstyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white70,
    fontWeight: FontWeight.w500,
  );

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
            child: isMyProfile
                ? IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile())),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    onPressed: () => print('Delete'),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 3.0),
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
                  child: Text(
                    'aapleasd;lkfjaslkdfjfasldk;fjasld l;askdjfasldkjfas;ldkfjsalfkjasd;lkfjadsl;kf lsakd;jafasld;kjfas;lkdfjad;lskjfslk;djf sadlkjfas;ldkfjs;aldkfjs;dalkfj',
                    style: titleTextstyle.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
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
                        border: Border.all(color: Colors.black45, width: 1.5)),
                    child: ClipOval(
                      child: Image.asset('assets/nsa_logo.jpg'),
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
