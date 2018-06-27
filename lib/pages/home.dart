import 'package:flutter/material.dart';

import '../components/home/cards.dart';
import '../data/main_data.dart';

class HomePage extends StatefulWidget {
  static final title = 'NSA News';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: publishedNews.length,
      itemBuilder: (_, index) => NewsCard(index),
    );
  }
}
