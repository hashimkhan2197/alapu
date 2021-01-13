import 'dart:ffi';

import 'package:alapu/alapAdminSection/pages/admin_panel/adminPanel_menu.dart';
import 'package:alapu/pages/login_page.dart';
import 'package:alapu/widgets/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _prefloading = false;
  String currentUserId;

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
//        onMessage: (msg)async{
//      print(msg);
//    },
//      onResume: (msg)async{
//      print(msg);
//      },
//      onLaunch: (msg)async{
//      print(msg);
//      },
//      onBackgroundMessage: (msg)async{
//      print(msg);
//      }
    );
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
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _prefloading == true
            ? Scaffold(body: Center())
            : StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                  if(snapshot.data['email']=='alapfirebase@gmail.com')
                    return AdminPanelMenu();
                  return snapshot.data['activated'] == false
                      ? Scaffold(
                        body: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("Su solicitud de membresía ha sido enviada. Espere entre 24 y 48 horas para la revisión.",style: TextStyle(fontSize: 18),),
                        )),
                      )
                      : Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.grey[50],
                      iconTheme: IconThemeData(color: Colors.blue),
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
                                      height: 130,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/alap_logo.png')),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),

                                    //user profile picture and name etc
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(
                                                snapshot.data['userImage']),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data['nombre'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              Text(
                                                'Membresía # ' +
                                                    snapshot.data['memberSince'],
                                                style: TextStyle(fontSize: 18),
                                              ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                menuIcon(
                                                    'assets/profile.png',
                                                    'Perfil',
                                                    PROFILE_SCREEN,
                                                    context),
                                                menuIcon(
                                                    'assets/notification.png',
                                                    'Noticias',
                                                    NOTIFICATION_SCREEN,
                                                    context),
                                                menuIcon(
                                                    'assets/calculator.png',
                                                    'Calculadora',
                                                    LICENSE_SCREEN,
                                                    context),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                menuIcon(
                                                    'assets/documents.png',
                                                    'Documentos',
                                                    DOCUMENT_SCREEN,
                                                    context),
                                                menuIcon(
                                                    'assets/certification.png',
                                                    'Certificación',
                                                    CERTIFICATION_SCREEN,
                                                    context),
                                                menuIcon(
                                                    'assets/forum.png',
                                                    'Foro',
                                                    FORUM_SCREEN,
                                                    context),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                menuIcon('assets/youtube.png',
                                                    'Youtube', '', context),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                    //Drawer
                    drawer: Drawer(
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: <Widget>[
                          //drawer header
                          UserAccountsDrawerHeader(
                            accountName: Text(
                              snapshot.data['nombre'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            accountEmail: Text('Membresía # ' +
                                snapshot.data['memberSince']),
                            currentAccountPicture: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data['userImage']),
                            ),
                          ),

                          drawerData('assets/profile.png', 'Perfil',
                              PROFILE_SCREEN, context),
                          Divider(
                            color: Colors.grey,
                          ),
                          drawerData('assets/notification.png', 'Noticias',
                              NOTIFICATION_SCREEN, context),
                          Divider(
                            color: Colors.grey,
                          ),
                          drawerData('assets/calculator.png', 'Calculadora',
                              LICENSE_SCREEN, context),
                          Divider(
                            color: Colors.grey,
                          ),
                          drawerData('assets/documents.png', 'Documentos',
                              DOCUMENT_SCREEN, context),
                          Divider(
                            color: Colors.grey,
                          ),
                          drawerData('assets/certification.png',
                              'Certificación', CERTIFICATION_SCREEN, context),
                          Divider(
                            color: Colors.grey,
                          ),
                          drawerData('assets/forum.png', 'Foro', FORUM_SCREEN,
                              context),
                          Divider(
                            color: Colors.grey,
                          ),
                          drawerData(
                              'assets/youtube.png', 'Youtube', '', context),
                          Divider(
                            color: Colors.grey,
                          ),

                          //Logout button
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 40),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }), (route) => false);
                              },
                              elevation: 3,
                              child: Text(
                                'Cerrar Sesión',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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

Widget drawerData(
    String iconimage, String title, String routeName, BuildContext context) {
  return ListTile(
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage(iconimage),
      backgroundColor: Colors.white,
    ),
    title: Text(title),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
  );
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
