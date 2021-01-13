import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
              stream:
              Firestore.instance.collection('notifications').orderBy('time',descending: true).snapshots(),
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
                              backgroundImage:
                              AssetImage('assets/notification.png'),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Noticias',
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
                      if(snapshot.data.documents.length == 0)
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Text("No Noticias",textAlign: TextAlign.center,),
                        )),

                      if(snapshot.data.documents.length > 0)
                        Expanded(
                            child: ListView.separated(
                              itemCount: snapshot.data.documents.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider();
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: notification(context,
                                      snapshot.data.documents[index]),
                                );
                              },
                            )),
                    ],
                  ),
                );
              }),
//          floatingActionButton: FloatingActionButton(
//            backgroundColor: Colors.blue[800],
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => AddNotification(),
//                ),
//              );
//            },
//            child: Icon(
//              Icons.add,
//              color: Colors.white,
//              size: 35,
//            ),
//          ),
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

Widget notification(context,
    DocumentSnapshot dataSnapshot) {
  return ListTile(

    title: Text(
      dataSnapshot.data['title'],
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    subtitle: Text(
      dataSnapshot.data['description'],
      style: TextStyle(color: Colors.black87, fontSize: 15),
    ),
    trailing: Text(
      dataSnapshot.data['time'].split('T').first,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}
