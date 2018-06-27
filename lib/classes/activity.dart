import 'package:cloud_firestore/cloud_firestore.dart';

import 'person.dart';

//Base class
class Activity {
  String content;
  DateTime datetime;
  String publisherID;
  String id;

  Activity({this.content, this.datetime, this.publisherID, this.id});
}

//Class for HomePage contents
class News extends Activity {
  int views = 0;
  String headline;
  List<String> images;
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

  factory News.fromDocument(DocumentSnapshot document) {
    return News(
        headline: document['headline'],
        content: document['content'],
        publisherID: document['publisherID'],
        views: document['views'],
        datetime: document['datetime'],
        id: document['id']);
  }
  factory News.fromUserDocument(DocumentSnapshot document) {
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

class Events extends Activity {}

class Tasks extends Activity {}
