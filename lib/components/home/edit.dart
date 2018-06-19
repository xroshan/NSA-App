import 'package:flutter/material.dart';

import '../../classes/activity.dart';

class EditNews extends StatefulWidget {
  final News news;
  EditNews([this.news]);

  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final _textControllerHeadline = TextEditingController();
  final _textControllerContent = TextEditingController();

  bool _isComposing = false;

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
    if (widget.news != null) {
      _textControllerHeadline.text = widget.news.headline;
      _textControllerContent.text = widget.news.content;
    }
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
                _textControllerContent.clear();
                _textControllerHeadline.clear();
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
              setState(() {
                _textControllerContent.clear();
                _textControllerHeadline.clear();
              });
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
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
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
                    onChanged: (String text) {
                      setState(() {
                        _isComposing = text.length > 0;
                      });
                    },
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
