import 'package:alapu/alapAdminSection/pages/Forum/forum_detail.dart';
import 'package:alapu/alapAdminSection/pages/admin_panel/add_forum_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminSectionForumPage extends StatefulWidget {
  AdminSectionForumPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AdminSectionForumPageState createState() => new _AdminSectionForumPageState();
}

class _AdminSectionForumPageState extends State<AdminSectionForumPage> {
  /// Top Icons
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: StreamBuilder(
              stream: Firestore.instance
                  .collection('forum')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      //alap logo
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        height: 100,
                        child: Image(image: AssetImage('assets/alap_logo.png')),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //notification heading and icon
                      Padding(
                        padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/forum.png'),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Foro',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //List of Notifications
                      if (snapshot.data.documents.length == 0)
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Center(
                            child: Text(
                              "No Topics",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),

                      if (snapshot.data.documents.length > 0)
                        Expanded(
                            child: ListView.separated(
                          itemCount: snapshot.data.documents.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: notification(
                                  snapshot.data.documents[index].data['title'],
                                  snapshot.data.documents[index]
                                      .data['description'],
                                  snapshot.data.documents[index].data['time']
                                      .split('T')
                                      .first,snapshot.data.documents[index],context),
                            );
                          },
                        )),
                    ],
                  ),
                );
              }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPanelAddForumQuestion(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
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
//        Positioned(
//          left: 0,
//          bottom: 0,
//          child: Image.asset(
//            "assets/down.png",
//            width: 100,
//          ),
//        ),
      ],
    );
  }
}

Widget notification(
    String notification_title, String notification_discription, String date,DocumentSnapshot dataSnapshot,BuildContext context) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
        border: Border.all(
      color: Colors.grey,
      width: 1,
    )),
    child: ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AdminSectionForumDetailPage(dataSnapshot);
        }));
      },
      title: Text(
        notification_title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        notification_discription,
        style: TextStyle(color: Colors.black87, fontSize: 15),
      ),
      trailing: Text(
        date,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
