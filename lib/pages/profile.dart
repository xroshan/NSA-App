import 'package:flutter/material.dart';

import 'package:nsa_prototype1/sample.dart';
import '../components/profile/profile_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var searchOption = 1;

  final nameTextstyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w600);

  Widget _buildUserList(BuildContext context, int index) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileView())),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Color(0xFF333366),
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/login2.webp',
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              person.firstName,
              style: nameTextstyle,
            ),
            Expanded(
              child: Container(),
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.message),
              onPressed: () => print('message was pressed'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(5.0),
      height: 50.0,
      color: Colors.black38,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              style: nameTextstyle.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () => _selectImage(),
          )
        ],
      ),
    );
  }

  _selectImage() {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new SimpleDialog(
          title: const Text('Search by'),
          children: <Widget>[
            new SimpleDialogOption(
                child: const Text('Name'),
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    searchOption = 1;
                  });
                }),
            new SimpleDialogOption(
                child: const Text('Major'),
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(() {
                    searchOption = 2;
                  });
                }),
            new SimpleDialogOption(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildUserList(context, -1),
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Divider(
              color: Colors.white,
              height: 1.0,
            ),
          ),
          _buildSearchBar(),
          SizedBox(
            height: 3.0,
          ),
          new Expanded(
            child: new Container(
              child: ListView.builder(
                itemBuilder: _buildUserList,
              ),
            ),
          )
        ],
      ),
    );
  }
}
