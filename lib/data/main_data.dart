import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../classes/person.dart';
import '../classes/activity.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

GoogleSignInAuthentication credentials;
GoogleSignInAccount user;

CollectionReference collectionUsers = Firestore.instance.collection('users');
DocumentReference referenceUser;
DocumentSnapshot documentUser;

Person userPerson = Person();
List<Person> people = [];

// Login Page

Future<Null> login() async {
  user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    user = await googleSignIn.signIn();
  }
  if (await auth.currentUser() != null) {
    credentials = await user.authentication;
    await auth.signInWithGoogle(
        idToken: credentials.idToken, accessToken: credentials.accessToken);
  }
}

//Navigator Page
Future<bool> hasUserRecord() async {
  documentUser = await collectionUsers.document(user.id).get();
  if (documentUser.exists) {
    referenceUser = collectionUsers.document(user.id);
    return true;
  } else {
    return false;
  }
}

Future<Null> createUserRecord() async {
  referenceUser = collectionUsers.document(user.id);
  referenceUser.setData({
    "id": user.id,
    "email": user.email,
    "displayName": '',
    "sex": '',
    "dob": '',
    "hometown": '',
    "currentAddress": '',
    "contactNumber": '',
    "major": '',
    "classification": '',
    "bio": ''
  });
}

Future<Null> loadPersonData() async {
  userPerson = Person.fromDocument(documentUser);
  var snap = await collectionUsers.getDocuments();
  for (var doc in snap.documents) {
    if (doc.documentID == documentUser.documentID) {
      continue;
    }
    people.add(Person.fromDocument(doc));
  }
}

//Profile Page
Future<Null> updateUserRecord() async {
  referenceUser.updateData({
    "displayName": userPerson.displayName,
    "sex": userPerson.sex,
    "dob": userPerson.dob,
    "hometown": userPerson.hometown,
    "currentAddress": userPerson.currentAddress,
    "contactNumber": userPerson.contactNumber,
    "major": userPerson.major,
    "classification": userPerson.classification,
    "bio": userPerson.bio
  });
}
