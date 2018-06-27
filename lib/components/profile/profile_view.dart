import 'package:flutter/material.dart';

import 'edit.dart';

import '../../data/main_data.dart';

class ProfileView extends StatelessWidget {
  final index;
  ProfileView(this.index);

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
            child: index == -1
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

  Widget _buildInfo(BuildContext context, String title, String value) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 3.0),
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
                  child: Text(
                    value,
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
                    image: NetworkImage(index == -1
                        ? userPerson.backgroundUrl
                        : people[index].backgroundUrl),
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
                      child: Image.network(index == -1
                          ? userPerson.photoUrl
                          : people[index].photoUrl),
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
                            index == -1
                                ? userPerson.displayName
                                : people[index].displayName),
                        _buildInfo(context, 'Sex',
                            index == -1 ? userPerson.sex : people[index].sex),
                        _buildInfo(context, 'Date of Birth',
                            index == -1 ? userPerson.dob : people[index].dob),
                        _buildInfo(
                            context,
                            'Hometown',
                            index == -1
                                ? userPerson.hometown
                                : people[index].hometown),
                        _buildInfo(
                            context,
                            'Current Address',
                            index == -1
                                ? userPerson.currentAddress
                                : people[index].currentAddress),
                        _buildInfo(
                            context,
                            'Contact Number',
                            index == -1
                                ? userPerson.contactNumber
                                : people[index].contactNumber),
                        _buildInfo(
                            context,
                            'Major',
                            index == -1
                                ? userPerson.major
                                : people[index].major),
                        _buildInfo(
                            context,
                            'Classification',
                            index == -1
                                ? userPerson.classification
                                : people[index].classification),
                        _buildInfo(context, 'Bio',
                            index == -1 ? userPerson.bio : people[index].bio),
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
