import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

//User Class.. 
class Person {                          //most of these info are displayed on ProfilePage
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

  factory Person.fromDocument(DocumentSnapshot document) {            //create person object from cloud firestore database
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



/*    waiting to be removed.. forgot specifically why i needed it
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


//Class for Board members of the organization.. maybe used in next release.. no use for now.
class VIP extends Person {
  String position;
  String clearanceLevel;

  VIP({@required displayName, @required this.position})
      : super(displayName: displayName);
}
