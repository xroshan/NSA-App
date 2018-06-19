import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../utils/column_builder.dart';
import '../../classes/activity.dart';
import '../../classes/person.dart';
import 'edit.dart';

class NewsDetailView extends StatefulWidget {
  final News news;
  NewsDetailView(this.news);
  @override
  _NewsDetailViewState createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;
  final commentTextstyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black87);
  final posterTextstyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black54);

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Column(
        children: <Widget>[
          Text(
            widget.news.headline,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('- ' + widget.news.publisher.firstName,
                  style: posterTextstyle),
              Container(
                height: 25.0,
                width: 25.0,
                margin: EdgeInsets.only(left: 3.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/login2.webp'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.0)),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0, right: 8.0),
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
          ),
        ],
      ),
    );
  }

  Widget _buildComments(BuildContext context, int i) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      padding: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Colors.black12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/login2.webp'),
        ),
        title: Text(
          widget.news.comments[i].publisher.firstName +
              ' (' +
              widget.news.datetime.month.toString() +
              '/' +
              widget.news.datetime.day.toString() +
              ')',
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline),
        ),
        subtitle: Text(
          widget.news.comments[i].content,
          style: commentTextstyle,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              widget.news.content,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: Colors.black54,
              height: 1.0,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              'Comments:',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          ColumnBuilder(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            itemCount: widget.news.comments.length,
            itemBuilder: _buildComments,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.black,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image(
            image: AssetImage('assets/login2.webp'),
            fit: BoxFit.contain,
          );
        },
        loop: false,
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(iconNext: null, iconPrevious: null),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          new InkWell(
            onTap: () => setState(() {
                  widget.news.heatUp();
                }),
            child: Icon(
              Icons.hot_tub,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Text(
              widget.news.heats.toString(),
              style: posterTextstyle,
            ),
          ),
          Container(
            width: 1.0,
            margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            color: Colors.black38,
          ),
          Icon(
            Icons.comment,
            color: Colors.blueAccent,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0, right: 12.0),
            child: Text(
              widget.news.comments.length.toString(),
              style: posterTextstyle,
            ),
          ),
          Expanded(
            child: new Container(
              padding: EdgeInsets.all(3.0),
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: Colors.black38, width: 1.0)),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration.collapsed(
                  hintText: 'Put your thoughts',
                ),
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _isComposing
                    ? (text) => setState(() {
                          widget.news.addComment(Messages(
                              content: _textController.text,
                              datetime: DateTime.now(),
                              publisher: Person('apple')));
                        })
                    : null,
              ),
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing
                  ? () => setState(() {
                        widget.news.addComment(Messages(
                            content: _textController.text,
                            datetime: DateTime.now(),
                            publisher: Person('apple')));
                      })
                  : null,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  _buildImage(),
                  Container(
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
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () => print('Delete'),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditNews(widget.news))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              new Expanded(
                  child: new Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildTitle(),
                          _buildContent(context),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.01)
                      ], stops: [
                        0.0,
                        0.9
                      ], begin: Alignment.topCenter, end: Alignment.center),
                    ),
                  ),
                ],
              )),
              _buildBottomBar()
            ],
          ),
        ),
      ),
    );
  }
}
