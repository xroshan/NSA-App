import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'home.dart';
import 'profile.dart';
import 'messages.dart';
import 'events.dart';
import 'tasks.dart';
import '../utils/frosted_screen.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  Widget bodyView = Container();
  String title = 'Dashboard';
  var isNavigate = true;

  Widget _buildGradientAppBar() {
    return Container(
      height: 66.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3366FF),
            const Color(0xFF00CCFF),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: ListTile(
        leading: IconButton(
            icon: Icon(Icons.dashboard),
            color: Colors.white,
            onPressed: () {
              setState(() {
                isNavigate ? isNavigate = false : isNavigate = true;
              });
            }),
        title: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () => print('add was pressed'),
        ),
      ),
    );
  }

  Widget _buildTile({@required Widget child, @required Function() onTap}) {
    return Material(
        color: Colors.blueAccent,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.black,
        child: InkWell(onTap: onTap, child: child));
  }

  Widget _buildDashboard() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: StaggeredGridView.count(
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            crossAxisCount: 2,
            shrinkWrap: false,
            children: <Widget>[
              _buildTile(
                  onTap: () {
                    setState(() {
                      title = 'Home';
                      isNavigate = false;
                      bodyView = HomePage();
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text('Home'),
                    ),
                  )),
              _buildTile(
                  onTap: () {
                    setState(() {
                      title = 'Profile';
                      isNavigate = false;
                      bodyView = ProfilePage();
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text('Profile'),
                    ),
                  )),
              _buildTile(
                  onTap: () {
                    setState(() {
                      title = 'Messages';
                      isNavigate = false;
                      bodyView = MessagesPage();
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text('Messages'),
                    ),
                  )),
              _buildTile(
                  onTap: () {
                    setState(() {
                      title = 'Events';
                      isNavigate = false;
                      bodyView = EventsPage();
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text('Events'),
                    ),
                  )),
              _buildTile(
                  onTap: () {
                    setState(() {
                      title = 'Tasks';
                      isNavigate = false;
                      bodyView = TasksPage();
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text('Tasks'),
                    ),
                  )),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 180.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 210.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 150.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF736AB7),
              Colors.black,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildGradientAppBar(),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  bodyView,
                  isNavigate
                      ? Frosted(
                          height: double.infinity,
                          width: double.infinity,
                        )
                      : Container(),
                  isNavigate ? _buildDashboard() : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
