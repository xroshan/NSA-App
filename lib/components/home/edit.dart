import 'package:flutter/material.dart';

import '../../data/main_data.dart';

class EditNews extends StatefulWidget {
  final int index;
  final bool isPublished;
  EditNews([this.index, this.isPublished]);

  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  int i;
  bool isPublished;
  bool isSaved = false;

  final _textControllerHeadline = TextEditingController();
  final _textControllerContent = TextEditingController();

  final commentTextstyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black87);

  final titleTextstyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black.withOpacity(0.60),
      decoration: TextDecoration.underline);

  final buttonTextstyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black87);

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      i = widget.index;
      if (widget.isPublished) {
        isPublished = widget.isPublished;

        _textControllerHeadline.text = publishedNews[i].headline;
        _textControllerContent.text = publishedNews[i].content;
      } else {
        _textControllerHeadline.text = savedNews[i].headline;
        _textControllerContent.text = savedNews[i].content;
      }
    } else {
      _create();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (!isSaved) {
      _delete();
    }
  }

  _delete() async {
    await deleteUserNews(i);
  }

  _save() async {
    isSaved = true;
    await saveNews(i);
  }

  _create() async {
    await createNews();
    await loadUserNewsData();
    i = savedNews.length - 1;
    isPublished = false;
  }

  _publish() async {
    await publishNews(i, isPublished);
  }

  Widget _buildButtonBar() {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            color: Colors.lightBlueAccent,
            onPressed: () {
              setState(() {
                _textControllerContent.clear();
                _textControllerHeadline.clear();
              });
            },
            child: Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(Icons.clear_all),
                ),
                Text(
                  'Clear',
                  style: buttonTextstyle,
                )
              ],
            ),
          ),
          RaisedButton(
            color: Colors.lightBlueAccent,
            onPressed: () {
              setState(() {
                _save();
                Navigator.pop(context);
              });
            },
            child: Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(Icons.save),
                ),
                Text(
                  'Save',
                  style: buttonTextstyle,
                )
              ],
            ),
          ),
          RaisedButton(
            color: Colors.lightBlueAccent,
            onPressed: () {
              _publish();
              Navigator.pop(context);
            },
            child: Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(Icons.publish),
                ),
                Text(
                  'Publish',
                  style: buttonTextstyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.black.withOpacity(0.03),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Text(
                  'Headline:',
                  style: titleTextstyle,
                ),
              ),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.black38, width: 1.0)),
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: TextField(
                  style: commentTextstyle,
                  maxLines: 2,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Give a headline',
                      hintStyle:
                          commentTextstyle.copyWith(color: Colors.black54)),
                  controller: _textControllerHeadline,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Content:',
                  style: titleTextstyle,
                ),
              ),
              Expanded(
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: Colors.black38, width: 1.0)),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextField(
                    style: commentTextstyle,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Write your content',
                        hintStyle:
                            commentTextstyle.copyWith(color: Colors.black54)),
                    controller: _textControllerContent,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Images:',
                  style: titleTextstyle,
                ),
              ),
              Container(
                height: 100.0,
                color: Colors.red,
              ),
              _buildButtonBar()
            ],
          ),
        ),
      ),
    );
  }
}
