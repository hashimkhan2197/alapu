import 'package:alapu/alapAdminSection/pages/admin_panel/pending_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PendingUserList extends StatefulWidget {
  @override
  _PendingUserListState createState() => _PendingUserListState();
}

class _PendingUserListState extends State<PendingUserList> {
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
                  .collection('users').where('activated',isEqualTo: false)
                 .orderBy('memberSince', descending: true)
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
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/profile.png'),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pendiente',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //List of Notifications
                      Expanded(
                          child: ListView.separated(
                        itemCount: snapshot.data.documents.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: userListTile(context,
                                  snapshot.data.documents[index]),
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                );
              }),
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

Widget userListTile(context,
    DocumentSnapshot dataSnapshot) {
  return ListTile(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return PendingUsers(dataSnapshot);
      }));
    },
    title: Text(
      dataSnapshot.data['nombre'],
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    subtitle: Text(
      dataSnapshot.data['email'],
      style: TextStyle(color: Colors.black87, fontSize: 15),
    ),
    trailing: Text(
        dataSnapshot.data['memberSince'].split('T').first,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}
