import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';
import 'messages.dart';
import 'events.dart';
import 'tasks.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  Widget _pages = HomePage();
  String _title = 'Home';

  final _drawerTextstyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(_title),
        ),
        body: _pages,
        drawer: Drawer(
          child: Container(
            margin: EdgeInsets.all(5.0),
            color: Colors.blueAccent,
            width: double.infinity,
            height: double.infinity,
            child: new Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Home',
                    style: _drawerTextstyle,
                  ),
                  onTap: () {
                    setState(() {
                      _title = 'Home';
                      _pages = HomePage();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Profile',
                    style: _drawerTextstyle,
                  ),
                  onTap: () {
                    setState(() {
                      _title = 'Profile';
                      _pages = ProfilePage();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Messages',
                    style: _drawerTextstyle,
                  ),
                  onTap: () {
                    setState(() {
                      _title = 'Messages';
                      _pages = MessagesPage();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Events',
                    style: _drawerTextstyle,
                  ),
                  onTap: () {
                    setState(() {
                      _title = 'Events';
                      _pages = EventsPage();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Tasks', style: _drawerTextstyle),
                  onTap: () {
                    setState(() {
                      _title = 'Tasks';
                      _pages = TasksPage();
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
