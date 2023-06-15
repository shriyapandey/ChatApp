import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'message.dart';
import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';

// ignore: camel_case_types, must_be_immutable
class chatpage extends StatefulWidget {
  String email;
  chatpage({super.key, required this.email});
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _chatpageState createState() => _chatpageState(email: email);
}

// ignore: camel_case_types
class _chatpageState extends State<chatpage> {
  String email;
  _chatpageState({required this.email});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool showEmoji = false;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            const Text(
              'Chat with Companian',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent),
                    onPressed: () {},
                    child: const Icon(Icons.call),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent),
                  onPressed: () {},
                  child: const Icon(Icons.video_call),
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
                    builder: (context) => const Home(),
                  ),
                );
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Sign-Out",
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: messages(
                    email: email,
                  ),
                ),
              ),

              //next bar

              Container(
                width: double.infinity,
                color: Colors.blue[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 45.0,
                          child: FloatingActionButton(
                            heroTag: UniqueKey(),
                            onPressed: () => {
                              showEmoji = true,
                            },
                            elevation: 25,
                            backgroundColor: Colors.lightBlue[500],
                            child: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Color.fromARGB(255, 150, 100, 143),
                          thickness: 2.0,
                        ),
                        SizedBox(
                          height: 45.0,
                          child: FloatingActionButton(
                            heroTag: UniqueKey(),
                            onPressed: () => {},
                            elevation: 25,
                            backgroundColor: Colors.lightBlue[500],
                            child: const Icon(
                              Icons.image,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                            color: Color.fromARGB(255, 150, 100, 143),
                            thickness: 2.0),
                        SizedBox(
                          height: 45.0,
                          child: FloatingActionButton(
                            heroTag: UniqueKey(),
                            onPressed: () => {},
                            elevation: 25,
                            backgroundColor: Colors.lightBlue[500],
                            child: const Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                height: 2.0,
                color: Color.fromARGB(255, 186, 153, 182),
              ),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
                color: Colors.blue[200],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: message,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            hintText: "Write message...",
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 7.0),
                      child: SizedBox(
                        height: 45.0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          onPressed: () => {
                            if (message.text.isNotEmpty)
                              {
                                fs.collection('Messages').doc().set({
                                  'message': message.text.trim(),
                                  'time': DateTime.now(),
                                  'email': email,
                                }),
                                message.clear(),
                              }
                          },
                          elevation: 5,
                          backgroundColor: Colors.lightBlue[500],
                          child: const Icon(
                            Icons.send_sharp,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              EmojiKeyboard(
                  emotionController: message,
                  emojiKeyboardHeight: 400,
                  showEmojiKeyboard: showEmoji,
                  darkMode: false),
            ],
          ),
        ),
      ),
    );
  }
}
