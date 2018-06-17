import 'person.dart';
import 'package:meta/meta.dart';

//Base class
class Activity {
  String content;
  DateTime datetime;
  Person publisher;

  Activity(
      {@required this.content,
      @required this.datetime,
      @required this.publisher})
      : assert(content != null),
        assert(datetime != null),
        assert(publisher != null);
}

//Class for HomePage contents
class News extends Activity {
  int heats = 0;
  String picture;
  String headline;
  List<Messages> comments = [];

  News({
    @required this.headline,
    @required content,
    @required datetime,
    @required publisher,
    this.picture,
  }) : super(content: content, datetime: datetime, publisher: publisher);

  void heatUp() => heats++;
  void heatDown() => heats--;

  void addComment(Messages text) => comments.add(text);
  void deleteComment(int index) => comments.removeAt(index);
}

//Class for ChatPage contents and comments contents
class Messages extends Activity {
  Messages(
      {@required content,
      @required datetime,
      @required publisher,
      this.receiver})
      : super(content: content, datetime: datetime, publisher: publisher);
  List<Person> receiver;
}

class Events extends Activity {}

class Tasks extends Activity {}
