import 'package:flutter/material.dart';

import '../classes/activity.dart';

class NewsCard extends StatefulWidget {
  final News news;

  NewsCard(this.news);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  static final headerTextStyle = const TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

  static final regularTextStyle = const TextStyle(
      color: Color(0xffb6b2df), fontSize: 14.0, fontWeight: FontWeight.w400);

  static final posterTextstyle = regularTextStyle.copyWith(fontSize: 16.0);

  Widget _buildNewsCardContent() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.white, width: 0.5)),
      padding: EdgeInsets.fromLTRB(75.0, 8.0, 8.0, 8.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.news.headline,
            style: headerTextStyle,
          ),
          Expanded(
            child: new Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                widget.news.content,
                style: regularTextStyle,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Divider(
            color: Colors.white,
            height: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.hot_tub,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.0, right: 12.0),
                child: Text(
                  widget.news.heats.toString(),
                  style: posterTextstyle,
                ),
              ),
              Icon(
                Icons.comment,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.0, right: 12.0),
                child: Text(
                  widget.news.commentsNumber().toString(),
                  style: posterTextstyle,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                '- ' + widget.news.publisher.firstName,
                style: posterTextstyle,
              ),
              Container(
                height: 25.0,
                width: 25.0,
                margin: EdgeInsets.only(left: 3.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/login2.webp'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.0)),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '(' +
                      widget.news.datetime.month.toString() +
                      '/' +
                      widget.news.datetime.day.toString() +
                      ')',
                  style: posterTextstyle,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNewsThumbnail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image(
          image: AssetImage('assets/login2.webp'), //TODO
          fit: BoxFit.cover,
          height: 110.0,
          width: 110.0,
        ),
      ),
    );
  }

  Widget _buildNewsCard() {
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
          color: Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0))
          ]),
      child: _buildNewsCardContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Stack(
        children: <Widget>[_buildNewsCard(), _buildNewsThumbnail()],
      ),
    );
  }
}
