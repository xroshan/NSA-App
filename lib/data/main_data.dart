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


//Local Database

final FirebaseAuth auth = FirebaseAuth.instance;                    //firebase authentication
final GoogleSignIn googleSignIn = GoogleSignIn();                   //google sign in authentication

GoogleSignInAuthentication credentials;
GoogleSignInAccount user;

CollectionReference collectionUsers = Firestore.instance.collection('users');             //instance 'users' collection in cloud firestore database
CollectionReference collectionUsersNews =
    collectionUsers.document(user.id).collection('savedNews');                          //instance 'savedNews' collection under current user
CollectionReference collectionUsersChatroom =
    collectionUsers.document(user.id).collection('chatrooms');                          //instance 'chatrooms' collection under current user

CollectionReference collectionNews = Firestore.instance.collection('news');

DocumentReference referenceUser; //all memberes
DocumentSnapshot documentUser;

DocumentReference referenceNews; //all news

DocumentReference referenceSavedNews; //saved news

StorageReference refStorage = FirebaseStorage.instance.ref();

//Local Data
Person userPerson = Person();               //loads the current user
List<Person> people = [];                   //loads all the user

List<News> publishedNews = [];                //loads all published news
List<News> savedNews = [];                    //loads all saved news under current user

File image;

// Functions used in Login Page

Future<Null> login() async {                          //google sign in function
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

//Function used in Navigator Page
Future<bool> hasUserRecord() async {                                    //checks if user has already registered                 
  documentUser = await collectionUsers.document(user.id).get();
  if (documentUser.exists) {
    referenceUser = collectionUsers.document(user.id);                    //loads the user database location into local database
    return true;
  } else {
    return false;
  }
}

Future<Null> createUserRecord() async {                               //creates new user record in remote database with default values
  referenceUser = collectionUsers.document(user.id);
  referenceUser.setData({
    "id": user.id,
    "email": user.email,
    "photoUrl":
        'https://firebasestorage.googleapis.com/v0/b/nsa-app-9daa9.appspot.com/o/1.png?alt=media&token=67a91441-9877-4c0e-8a61-2f66d6db6973',             //TODO, needs to be replaced
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

Future<Null> loadPersonData() async {                                 //load all the users 
  userPerson = Person.fromDocument(documentUser);
  var snap = await collectionUsers.getDocuments();
  for (var doc in snap.documents) {
    if (doc.documentID == documentUser.documentID) {
      continue;
    }
    people.add(Person.fromDocument(doc));
  }
}

//Functions used in Home Page

Future<Null> loadNewsData() async {                               //load all published news in local database
  var snap = await collectionNews.getDocuments();
  for (var doc in snap.documents) {
    publishedNews.add(News.fromDocument(doc));
  }
}

Future<Null> loadUserNewsData() async {                           //loads all saved news under current user in local database
  var snap = await collectionUsersNews.getDocuments();
  for (var doc in snap.documents) {
    savedNews.add(News.fromUserDocument(doc));
  }
}

Future<Null> createNews() async {                                           //creates a new news with default value under current user database
  referenceSavedNews = collectionUsersNews.document();
  await referenceSavedNews.setData({
    "headline": '',
    "content": '',
    "images": '',
    "datetime": DateTime.now(),
    "id": referenceSavedNews.documentID,
  });
}

Future<Null> saveNews(int index) async {                                        //save the news under current user database
  referenceSavedNews = collectionUsersNews.document(savedNews[index].id);
  await referenceSavedNews.updateData({
    "headline": savedNews[index].headline,
    "content": savedNews[index].content,
    "images": '',
    "datetime": DateTime.now(),
  });
}

Future<Null> publishNews(int index, bool isPublished) async {                       //publish the news to public.. loads the news into public news database
  if (isPublished) {                                                            //checks if it has already been published
    referenceNews = collectionNews.document(publishedNews[index].id);                   //if already published, finds the news and modifies it
    await referenceNews.updateData({
      "headline": publishedNews[index].headline,
      "content": publishedNews[index].content,
      "images": '',
      "datetime": DateTime.now(),
    });
  } else {                                                                      //if not creates new reference in news and publishes it with default values
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

Future<Null> editNews(int index) async {                                        //edits the published news.. TODO.. incomplete
  referenceNews = collectionNews.document(publishedNews[index].id);
  await referenceNews.updateData({
    "headline": publishedNews[index].headline,
    "content": publishedNews[index].content,
    "images": '',
    "datetime": DateTime.now()
  });
}

Future<Null> deleteUserNews(int index) async {                                      //delete the saved news under user database
  await collectionUsersNews.document(savedNews[index].id).delete();
}

Future<Null> deleteNews(int index) async {                                      //delete the published news
  await collectionNews.document(publishedNews[index].id).delete();
}

//Functions used in Profile Page
Future<Null> updateUserRecord() async {                                                 //update the current user record
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

Future<Null> updateUserImage() async {                                        //update the current user image.. both personal and background pic
  referenceUser.updateData({
    "photoUrl": userPerson.photoUrl,
    "backgroundUrl": userPerson.backgroundUrl,
  });
}

Future<String> uploadPhoto() async {                                                  //upload picture in firebase storage.. TODO.. a better file structure is needed in database
  final ByteData bytes = await rootBundle.load(image.path);                       //convert image to byte data
  final Directory tempDir = Directory.systemTemp;                                   //get the directory path of the image
  final String fileName = "${Random().nextInt(10000)}.jpg";                           //get the random string name for image
  final File file = File('${tempDir.path}$fileName');                                   //creates a file in that directory 
  file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);                   //write the byte data in that files

  final StorageReference ref = refStorage.child(fileName);                              //create a reference in firebase storage
  final StorageUploadTask task = ref.putFile(file);                                       //upload the filename
  final Uri downloadUrl = (await task.future).downloadUrl;                              //get the download url
  image = null;                                                                       //set local buffer image variable to zero for next use
  return downloadUrl.toString();                                                    
}
