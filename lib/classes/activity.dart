import 'package:cloud_firestore/cloud_firestore.dart';

import 'person.dart';

//Base class for all the activities performed by user
class Activity {
  String content;
  DateTime datetime;
  String publisherID;
  String id;

  Activity({this.content, this.datetime, this.publisherID, this.id});
}

//Class for HomePage contents.. contains News
class News extends Activity {
  int views = 0;                          //tracks no. of views
  String headline;
  List<String> images;                        //images to be used in news
  List<Messages> comments = [];

  News(
      {this.headline,
      content,
      datetime,
      publisherID,
      id,
      this.images,
      this.comments,
      this.views})
      : super(
            content: content,
            datetime: datetime,
            publisherID: publisherID,
            id: id);

  factory News.fromDocument(DocumentSnapshot document) {                //create news object from Json document in cloud firestore database
    return News(
        headline: document['headline'],
        content: document['content'],
        publisherID: document['publisherID'],
        views: document['views'],
        datetime: document['datetime'],
        id: document['id']);
  }
  factory News.fromUserDocument(DocumentSnapshot document) {                //create news object from Json document in cloud firestore from user document
    return News(
        headline: document['headline'],
        content: document['content'],
        datetime: document['datetime'],
        id: document['id']);
  }
}

//Class for ChatPage contents and comments contents
class Messages extends Activity {                 
  Messages({content, datetime, publisherID, this.receiver})
      : super(content: content, datetime: datetime, publisherID: publisherID);
  List<Person> receiver;
}


//TODO after first release

//Class for EventPage contents
class Events extends Activity {}

//Class for TaskPage contents..
class Tasks extends Activity {}
