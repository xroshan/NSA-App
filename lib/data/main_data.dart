import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../classes/person.dart';
import '../classes/activity.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

GoogleSignInAuthentication credentials;
GoogleSignInAccount user;

CollectionReference collectionUsers = Firestore.instance.collection('users');
CollectionReference collectionUsersNews =
    collectionUsers.document(user.id).collection('savedNews');
CollectionReference collectionUsersChatroom =
    collectionUsers.document(user.id).collection('chatrooms');

CollectionReference collectionNews = Firestore.instance.collection('news');

DocumentReference referenceUser; //all memberes
DocumentSnapshot documentUser;

DocumentReference referenceNews; //all news

DocumentReference referenceSavedNews; //saved news

StorageReference refStorage = FirebaseStorage.instance.ref();

//Local Data
Person userPerson = Person();
List<Person> people = [];

List<News> publishedNews = [];
List<News> savedNews = [];

File image;

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
    "photoUrl":
        'https://firebasestorage.googleapis.com/v0/b/nsa-app-9daa9.appspot.com/o/1.png?alt=media&token=67a91441-9877-4c0e-8a61-2f66d6db6973',
    "backgroundUrl":
        'https://firebasestorage.googleapis.com/v0/b/nsa-app-9daa9.appspot.com/o/2.png?alt=media&token=fe945fe1-01af-40a7-98ba-0f6701e7f99d',
    "displayName": user.email,
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

//Home Page

Future<Null> loadNewsData() async {
  var snap = await collectionNews.getDocuments();
  for (var doc in snap.documents) {
    publishedNews.add(News.fromDocument(doc));
  }
}

Future<Null> loadUserNewsData() async {
  var snap = await collectionUsersNews.getDocuments();
  for (var doc in snap.documents) {
    savedNews.add(News.fromUserDocument(doc));
  }
}

Future<Null> createNews() async {
  referenceSavedNews = collectionUsersNews.document();
  await referenceSavedNews.setData({
    "headline": '',
    "content": '',
    "images": '',
    "datetime": DateTime.now(),
    "id": referenceSavedNews.documentID,
  });
}

Future<Null> saveNews(int index) async {
  referenceSavedNews = collectionUsersNews.document(savedNews[index].id);
  await referenceSavedNews.updateData({
    "headline": savedNews[index].headline,
    "content": savedNews[index].content,
    "images": '',
    "datetime": DateTime.now(),
  });
}

Future<Null> publishNews(int index, bool isPublished) async {
  if (isPublished) {
    referenceNews = collectionNews.document(publishedNews[index].id);
    await referenceNews.updateData({
      "headline": publishedNews[index].headline,
      "content": publishedNews[index].content,
      "images": '',
      "datetime": DateTime.now(),
    });
  } else {
    // print('new newssss');
    referenceNews = collectionNews.document();
    await referenceNews.setData({
      "headline": savedNews[index].headline,
      "content": savedNews[index].content,
      "images": '',
      "datetime": DateTime.now(),
      "id": referenceNews.documentID,
      "publisher": user.id,
      "views": 0
    });
    await collectionUsersNews.document(savedNews[index].id).delete();
  }
}

Future<Null> editNews(int index) async {
  referenceNews = collectionNews.document(publishedNews[index].id);
  await referenceNews.updateData({
    "headline": publishedNews[index].headline,
    "content": publishedNews[index].content,
    "images": '',
    "datetime": DateTime.now()
  });
}

Future<Null> deleteUserNews(int index) async {
  await collectionUsersNews.document(savedNews[index].id).delete();
}

Future<Null> deleteNews(int index) async {
  await collectionNews.document(publishedNews[index].id).delete();
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

Future<Null> updateUserImage() async {
  referenceUser.updateData({
    "photoUrl": userPerson.photoUrl,
    "backgroundUrl": userPerson.backgroundUrl,
  });
}

Future<String> uploadPhoto() async {
  final ByteData bytes = await rootBundle.load(image.path);
  final Directory tempDir = Directory.systemTemp;
  final String fileName = "${Random().nextInt(10000)}.jpg";
  final File file = File('${tempDir.path}$fileName');
  file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

  final StorageReference ref = refStorage.child(fileName);
  final StorageUploadTask task = ref.putFile(file);
  final Uri downloadUrl = (await task.future).downloadUrl;
  image = null;
  return downloadUrl.toString();
}
