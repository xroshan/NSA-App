import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';







//TODO.. this was all for test.. needs to be build from begining...

class ChatPage extends StatefulWidget {
  final FirebaseAuth _auth;
  final GoogleSignIn googleSignIn;

  const ChatPage(this.googleSignIn, this._auth);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  final reference = FirebaseDatabase.instance.reference().child('messages');
  final analytics = FirebaseAnalytics();

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = widget.googleSignIn.currentUser;
    if (user == null) {
      user = await widget.googleSignIn.signInSilently();
    }
    if (user == null) {
      user = await widget.googleSignIn.signIn();
      analytics.logLogin();
    }
    if (await widget._auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await widget.googleSignIn.currentUser.authentication;
      await widget._auth.signInWithGoogle(
          idToken: credentials.idToken, accessToken: credentials.accessToken);
    }
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              controller: _textController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              onSubmitted:
                  _isComposing ? (String text) => _handleSubmitted(text) : null,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)
                  : null,
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _handleSubmitted(String text) async {
    _textController.clear();

    setState(() {
      _isComposing = false;
    });
    await _ensureLoggedIn();
    _sendMessage(text: text);
  }

  void _sendMessage({String text}) {
    reference.push().set({
      'text': text,
      'senderName': widget.googleSignIn.currentUser.displayName,
      'senderPhotoUrl': widget.googleSignIn.currentUser.photoUrl,
    });
    analytics.logEvent(name: 'send_message');
  }

  Widget _buildChatMessage(DataSnapshot snapshot) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.value['senderPhotoUrl']),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(snapshot.value['senderName']),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(snapshot.value['text']),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: FirebaseAnimatedList(
                  query: reference,
                  sort: (a, b) => b.key.compareTo(a.key),
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, DataSnapshot snapshot,
                          Animation<double> animation, int i) =>
                      _buildChatMessage(snapshot))),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}
