import 'package:flutter/material.dart';

import '../components/home/cards.dart';
import '../data/main_data.dart';

//Home page
class HomePage extends StatefulWidget {
  static final title = 'NSA News';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(                    //loads the news card with news in local database
      itemCount: publishedNews.length,
      itemBuilder: (_, index) => NewsCard(index), 
    );
  }
}
