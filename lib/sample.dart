import 'classes/activity.dart';
import 'classes/person.dart';

//local database for test

Person person = Person(displayName: 'Apple');

News news = News(
    publisherID: person,
    content:
        "There is going to be very big event on town. There is going to be very big event on town. There is going to be very big event on town. There is going to be very big event on town. This is very exciting. There is going to be very big event on town. This is very exciting. There is going to be very big event on town. This is very exciting.",
    datetime: DateTime.now(),
    headline: 'Big Event');

Messages messages = Messages(
    content: 'Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!Very Excited!!', datetime: DateTime.now(), publisherID: person);
