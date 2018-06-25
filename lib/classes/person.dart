import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Person {
  String displayName;
  String id;
  String photoUrl;
  String backgroundUrl;
  String email;
  String sex;
  String dob;
  String major;
  String classification;
  String hometown;
  String currentAddress;
  String contactNumber;
  String bio;

  Person(
      {this.displayName = '',
      this.id,
      this.photoUrl,
      this.backgroundUrl,
      this.email,
      this.sex = '',
      this.dob = '',
      this.major = '',
      this.classification = '',
      this.hometown = '',
      this.currentAddress = '',
      this.contactNumber = '',
      this.bio = ''});

  factory Person.fromDocument(DocumentSnapshot document) {
    return Person(
        displayName: document['displayName'],
        id: document['id'],
        photoUrl: document['photoUrl'],
        backgroundUrl: document['backgroundUrl'],
        email: document['email'],
        sex: document['sex'],
        dob: document['dob'],
        major: document['major'],
        classification: document['classification'],
        hometown: document['hometown'],
        currentAddress: document['currentAddress'],
        contactNumber: document['contactNumber'],
        bio: document['bio']);
  }
}

/*
 if (widget.user != null) {
      ref.document(widget.user.id).setData({
        "id": widget.user.id,
        "email": widget.user.email,
        "displayName": '-',
        "sex": '-',
        "dob": '-',
        "hometown": '-',
        "currentAddress": '-',
        "contactNumber": '-',
        "major": '-',
        "classification": '-',
        "bio": '-'
      });
    }

    */

class VIP extends Person {
  String position;
  String clearanceLevel;

  VIP({@required displayName, @required this.position})
      : super(displayName: displayName);
}
