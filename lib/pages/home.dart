import 'package:flutter/material.dart';

import '../components/cards.dart';
import '../classes/person.dart';
import '../classes/activity.dart';

class HomePage extends StatefulWidget {
  static final title = 'NSA News';
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final news = News(
      poster: Person('Johnny'),
      content:
          "There is going to be very big event on town. There is going to be very big event on town. There is going to be very big event on town. There is going to be very big event on town. This is very exciting. There is going to be very big event on town. This is very exciting. There is going to be very big event on town. This is very exciting.",
      datetime: DateTime.now(),
      headline: 'Big Event');

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        NewsCard(news),
        NewsCard(news),
        NewsCard(news),
        NewsCard(news),
        NewsCard(news),
        NewsCard(news),
      ],
    );
  }
}
