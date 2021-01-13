import 'package:alapu/alapAdminSection/pages/certification.dart';
import 'package:alapu/alapAdminSection/pages/documents_page.dart';
import 'package:alapu/alapAdminSection/pages/my_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/constant.dart';
import 'package:flutter/rendering.dart';

class PendingUsers extends StatefulWidget {
  final DocumentSnapshot userSnapshot;

  PendingUsers(this.userSnapshot);

  @override
  _PendingUsersState createState() => _PendingUsersState();
}

class _PendingUsersState extends State<PendingUsers> {
  bool approvalGranted;

  @override
  void initState() {
    approvalGranted = widget.userSnapshot.data['activated'];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(color: Colors.black),
//            title: Text('Pending User', style: TextStyle(color: Colors.black, fontSize: 16),),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // alap logo
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
                      height: 100,
                      child: Image(image: AssetImage('assets/alap_logo.png')),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //user profile picture and name etc
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                widget.userSnapshot.data['userImage']),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                widget.userSnapshot.data['nombre'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
//                              Text(
//                                'Membresia: ' +
//                                    widget.userSnapshot.data['memberSince']
//                                        .split('T')
//                                        .first,
//                                style: TextStyle(),
//                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //menu Icons, 3 icons in each row
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AdminSectionMyProfile(widget.userSnapshot,approvalGranted);
                                    }));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/profile.png'),
                                        backgroundColor: Colors.white,
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Perfil'),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return AdminSectionDocuments(widget.userSnapshot);
                                        }));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage:
                                        AssetImage('assets/documents.png'),
                                        backgroundColor: Colors.white,
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Documentos'),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return AdminSectionCertification(widget.userSnapshot);
                                        }));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage:
                                        AssetImage('assets/certification.png'),
                                        backgroundColor: Colors.white,
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Certificacion'),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: () {
                          if (approvalGranted == false) {
                            Firestore.instance
                                .collection('users')
                                .document(widget.userSnapshot.documentID)
                                .updateData({'activated': true}).catchError(
                                    (e) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.red[400],
                                        )),
                                    title: Text("Error"),
                                    content: Text(
                                        "Error: Please check your Internet Connection"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style:
                                              TextStyle(color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                            setState(() {
                              approvalGranted = true;
                            });
                          } else {
                            Firestore.instance
                                .collection('users')
                                .document(widget.userSnapshot.documentID)
                                .updateData({'activated': false}).catchError(
                                    (e) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.red[400],
                                        )),
                                    title: Text("Error"),
                                    content: Text(
                                        "Error: Please check your Internet Connection"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style:
                                              TextStyle(color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                            setState(() {
                              approvalGranted = false;
                            });
                          }
                        },
                        color: Colors.blue[800],
                        textColor: Colors.white,
                        child: Text(
                          approvalGranted == false
                              ? "Aprobar Miembro"
                              : "Suspender Miembro",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 20),
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(5.0)),
//                        padding: EdgeInsets.only(
//                            top: 10, bottom: 10, left: 30, right: 30),
//                        onPressed: () {},
//                        color: Colors.blue[800],
//                        textColor: Colors.white,
//                        child: Text(
//                          'Reject',
//                          style: TextStyle(fontSize: 17),
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ],
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

Widget menuIcon(
    String icon, String name, String routeName, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
    child: Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(icon),
          backgroundColor: Colors.white,
          radius: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(name),
      ],
    ),
  );
}
