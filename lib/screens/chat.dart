import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easychat/components/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'Chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String messageText;
  User _user;

  void getCurrentUser() async {
    try {
      final loggeduser = _auth.currentUser;
      if (loggeduser != null) {
        _user = loggeduser;
        print(_user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EasyChat'),
          actions: [
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                })
          ],
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("messages").snapshots(),
                builder: (buildcontext, snapshot) {
                  final List<MessageBunble> messagesText = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data.docs.reversed;
                  for (var message in messages) {
                    final textmessage = message.data()['text'];
                    final sender = message.data()['sender'];
                    messagesText.add(
                      MessageBunble(
                        sender: sender,
                        text: textmessage,
                        user: _user,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        children: messagesText),
                  );
                }),
            Container(
              child: Card(
                elevation: 5,
                              child: Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      textEditingController.clear();
                      _firestore
                          .collection("messages")
                          .add({'text': messageText, 'sender': _user.email});
                    },
                    child: Text('Send'),
                  )
                ]),
              ),
            ),
          ],
        )));
  }
}

class MessageBunble extends StatelessWidget {
  String text, sender;
  User user;
  MessageBunble({this.text, this.sender, this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: user.email == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
          Material(
              elevation: 5,
              borderRadius: user.email == sender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: user.email == sender ? Colors.lightBlue : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: user.email == sender ? Colors.white : Colors.black,
                      fontSize: 16.0),
                ),
              )),
        ],
      ),
    );
  }
}
