import 'package:alapu/pages/admin_panel/answer_forum_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForumDetailPage extends StatefulWidget {
  final DocumentSnapshot topicSnapshot;

  ForumDetailPage(this.topicSnapshot);

  @override
  _ForumDetailPageState createState() => new _ForumDetailPageState();
}

var ForumPostArr = [
  new ForumPostEntry("User1", "2 Days ago", 0, 0,
      "Hello,\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  new ForumPostEntry("User2", "23 Hours ago", 1, 0,
      "Pellentesque justo metus, finibus porttitor consequat vitae, tincidunt vitae quam. Vestibulum molestie sem diam. Nullam pretium semper tempus. Maecenas lobortis lacus nunc, id lacinia nunc imperdiet tempor. Mauris mi ipsum, finibus consectetur eleifend a, maximus eget lorem. Praesent a magna nibh. In congue sapien sed velit mattis sodales. Nam tempus pulvinar metus, in gravida elit tincidunt in. Curabitur sed sapien commodo, fringilla tortor eu, accumsan est. Proin tincidunt convallis dolor, a faucibus sapien auctor sodales. Duis vitae dapibus metus. Nulla sit amet porta ipsum, posuere tempor tortor.\n\nCurabitur mauris dolor, cursus et mi id, mattis sagittis velit. Duis eleifend mi et ante aliquam elementum. Ut feugiat diam enim, at placerat elit semper vitae. Phasellus vulputate quis ex eu dictum. Cras sapien magna, faucibus at lacus vel, faucibus viverra lorem. Phasellus quis dui tristique, ultricies velit non, cursus lectus. Suspendisse neque nisl, vestibulum non dui in, vulputate placerat elit. Sed at convallis mauris, eu blandit dolor. Vivamus suscipit iaculis erat eu condimentum. Aliquam erat volutpat. Curabitur posuere commodo arcu vel consectetur."),
  new ForumPostEntry("User3", "2 Days ago", 5, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  new ForumPostEntry("User4", "2 Days ago", 0, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
];

class _ForumDetailPageState extends State<ForumDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: new Text(
                    widget.topicSnapshot.data['title'],
                    textScaleFactor: 1.5,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    widget.topicSnapshot.data['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: new IconWithText(
                      "Posted by: ", widget.topicSnapshot.data['memberName']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                      child: new IconWithText("Date: ",
                          widget.topicSnapshot.data['time'].split('T').first),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)
                        ),
//                  width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return AnswerForumQuestion(widget.topicSnapshot);
                            }));
                          },
                          child: Text(
                            'Reply',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                  ],
                ),

                new Divider()
              ],
            ),
          ),
          StreamBuilder(
              stream: Firestore.instance.collection('forum').document(widget.topicSnapshot.documentID).collection('answers').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(snapshot.data.documents.length == 0){
                  return Expanded(
                    child: Center(
                      child: Text('No Replies'),
                    ),
                  );
                }

                return new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: new ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot replySnapshot =snapshot.data.documents[index];
                              ForumPostEntry answerBody =ForumPostEntry(replySnapshot.data['memberName'],
                                  replySnapshot.data['time'].split("T").first,
                                  0,0, replySnapshot.data['description']
                              );
                              return ForumPost(answerBody);
                            },
                            itemCount: snapshot.data.documents.length,
                          )),
                    ));
              }
          )
        ],
      ),
    );
  }
}

class ForumPostEntry {
  final String username;
  final String hours;
  final int likes;
  final int dislikes;
  final String text;

  ForumPostEntry(
      this.username, this.hours, this.likes, this.dislikes, this.text);
}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;

  ForumPost(this.entry);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0)),
            ),
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.white,
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(entry.username),
                      new Text(entry.hours),
                    ],
                  ),
                ),
//                new Row(
//                  children: <Widget>[
//                    new Padding(
//                      padding: const EdgeInsets.all(2.0),
//                      child: new Icon(
//                        Icons.thumb_up,
//                        color: Colors.white,
//                      ),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.all(2.0),
//                      child: new Text(entry.likes.toString()),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.all(2.0),
//                      child: new Icon(
//                        Icons.thumb_down,
//                        color: Colors.white,
//                      ),
//                    ),
//                    new Padding(
//                      padding: const EdgeInsets.only(right: 8.0, left: 2.0),
//                      child: new Text(entry.dislikes.toString()),
//                    ),
//                  ],
//                )
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
            padding: const EdgeInsets.all(12.0),
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0))),
            child: new Text(entry.text),
          ),
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final String iconData;
  final String text;
  final Color iconColor;

  IconWithText(this.iconData, this.text, {this.iconColor});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              this.iconData,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              this.text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
