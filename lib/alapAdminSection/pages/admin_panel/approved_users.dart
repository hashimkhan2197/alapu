import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ApprovedUsers extends StatefulWidget {
  ApprovedUsers({Key key}) : super(key: key);

  @override
  _ApprovedUsersState createState() => _ApprovedUsersState();
}

class _ApprovedUsersState extends State<ApprovedUsers> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Approved User',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
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
                            backgroundImage:
                                AssetImage('assets/profile_picture.png'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Humberto A Lazo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                'Membresia # XX-XX-XX',
                                style: TextStyle(),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
//                                menuIcon('assets/profile.png', 'Perfil',
//                                    ADMIN_PROFILE_SCREEN, context),
//                                menuIcon('assets/documents.png', 'Documentos',
//                                    ADMIN_DOCUMENT_SCREEN, context),
//                                menuIcon(
//                                    'assets/certification.png',
//                                    'Certificacion',
//                                    ADMIN_CERTIFICATION_SCREEN,
//                                    context),
                              ],
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
