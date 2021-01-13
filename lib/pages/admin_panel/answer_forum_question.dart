import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnswerForumQuestion extends StatefulWidget {
  final DocumentSnapshot topicSnapshot;

  AnswerForumQuestion(this.topicSnapshot);

  @override
  _AnswerForumQuestionState createState() => _AnswerForumQuestionState();
}

class _AnswerForumQuestionState extends State<AnswerForumQuestion> {
//  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: '');
  bool _prefloading = false;
  String currentUserId;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      FirebaseUser authResult = await FirebaseAuth.instance.currentUser();
      setState(() {
        currentUserId = authResult.uid;
        _prefloading = false;
        print(currentUserId);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
//    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Foro Reply',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: _prefloading == true
              ? Center()
              : StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(currentUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(body: Center(child: CircularProgressIndicator(),));
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 50),
                    //alap logo
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: 100,
                      child: Image(image: AssetImage('assets/alap_logo.png')),
                    ),
                    SizedBox(height: 50),
                    //notification title
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Container(
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black.withOpacity(0.1),
//                          blurRadius: 10,
//                          offset: Offset(0, 5),
//                        ),
//                      ],
//                    ),
//                    child: TextFormField(
//                      controller: titleController,
//                      minLines: 2,
//                      maxLines: null,
//                      decoration: InputDecoration(
//                        hintText: 'Title',
//                        hintStyle: TextStyle(fontSize: 16),
//                        enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(5.0),
//                          borderSide: BorderSide(color: Colors.transparent),
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(5.0),
//                          borderSide: BorderSide(
//                            color: Colors.transparent,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//                SizedBox(height: 20),
//                //notification Description
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: null,
                          controller: descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Please write your reply here...',
                            hintStyle: TextStyle(fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 30, right: 30),
                        color: Colors.blue[800],
                        textColor: Colors.white,
                        child: Text(
                          'Reply',
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () {
                          if (descriptionController.text.trim() == '') {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red[400],
                                      )),
                                  title: Text("Note"),
                                  content: Text("Reply must not be empty."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          } else {
                            Firestore.instance
                                .collection('forum')
                                .document(widget.topicSnapshot.documentID)
                                .collection('answers')
                                .add({
//                          'title': titleController.text.trim(),
                              'description': descriptionController.text.trim(),
                              'time': DateTime.now().toIso8601String(),
                              'memberName': snapshot.data['nombre'],
                              'memberEmail': snapshot.data['email'],
                            }).then((value) {
                              Navigator.pop(context);
                            }).catchError((e) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.red[400],
                                        )),
                                    title: Text("Error!!"),
                                    content: Text(
                                        "Response Failed! Please check your internet connection or try again after some time."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset(
            "assets/up.png",
            width: 100,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset(
            "assets/down.png",
            width: 100,
          ),
        ),
      ],
    );
  }
}
