import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'message.dart';

class chatpage extends StatefulWidget {
  String email;
  chatpage({required this.email});
  @override
  _chatpageState createState() => _chatpageState(email: email);
}

class _chatpageState extends State<chatpage> {
  String email;
  _chatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Chat with Companian',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                  onPressed: () {},
                  child: Icon(Icons.call),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                  onPressed: () {},
                  child: Icon(Icons.video_call),
                ),
              ],
            )
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              _auth.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign-Out",
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: messages(
                email: email,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.indigo[100],
                      hintText: 'Write your message here....',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 5.0, bottom: 8.0, top: 5.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.lightBlue),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.blue),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {},
                    onSaved: (value) {
                      message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('Messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        'email': email,
                      });

                      message.clear();
                    }
                  },
                  icon: Row(
                    children: [
                      Icon(Icons.send_sharp),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
