import 'package:flutter/material.dart';

import '../../data/main_data.dart';             //local database

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

  final commentTextstyle = TextStyle(                                           //some text fonts
      fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black87);

  final titleTextstyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black.withOpacity(0.60),
      decoration: TextDecoration.underline);

  final buttonTextstyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black87);

  @override
  void initState() {                            //override initState() to display the news contents if edited the existing news..
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
    super.dispose();                            //override dispose() to delete the unsaved news.
    if (!isSaved) {
      _delete();
    }
  }

  _delete() async {                           //delete news
    await deleteUserNews(i);
  }

  _save() async {                     //save news to remote database
    isSaved = true;
    await saveNews(i);                        //call to local database 
  }

  _create() async {                               //create new news         
    await createNews();
    await loadUserNewsData();
    i = savedNews.length - 1;
    isPublished = false;
  }

  _publish() async {                                  //publish news when ready
    await publishNews(i, isPublished);
  }

  Widget _buildButtonBar() {                              //goes to bottom of screen.. save and publish buttons..
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
                _textControllerContent.clear();                       //clear buttons clear headline and contents.. 
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
                _save();                                    //save news in cloud firestore database.. user database
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
              _publish();                                           //publish to public world.. displayed in homepage..TODO
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
  Widget build(BuildContext context) {              //main builder
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
                  controller: _textControllerHeadline,                            //user text field to input headline 
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
                    controller: _textControllerContent,                 //user text field to input news contents
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Images:',                                //TODO.. upload images needs to be done.. max up to 8 images..
                  style: titleTextstyle,
                ),
              ),
              Container(
                height: 100.0,
                color: Colors.red,
              ),
              _buildButtonBar()                                     //goes to the bottom of screen.. contains save, publish buttons
            ],
          ),
        ),
      ),
    );
  }
}
