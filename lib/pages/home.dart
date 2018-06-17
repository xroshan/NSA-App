import 'package:flutter/material.dart';

import '../components/home/cards.dart';
import '../sample.dart';

class HomePage extends StatefulWidget {
  static final title = 'NSA News';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
