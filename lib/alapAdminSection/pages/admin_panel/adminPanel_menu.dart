import 'package:alapu/alapAdminSection/pages/admin_panel/pending_user_list.dart';
import 'package:alapu/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'adminpenal_login.dart';
import '../../widgets/constant.dart';
import 'package:flutter/material.dart';

class AdminPanelMenu extends StatefulWidget {
  AdminPanelMenu({Key key}) : super(key: key);

  @override
  _AdminPanelMenuState createState() => _AdminPanelMenuState();
}

class _AdminPanelMenuState extends State<AdminPanelMenu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'ALAP Administración',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Material(
            child: Column(
              children: [
                SizedBox(height: 30),
                //alap logo
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 100,
                  child: Image(image: AssetImage('assets/alap_logo.png')),
                ),
                SizedBox(height: 30),
                new Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _button('Noticias', Icons.notifications_none,
                            Icons.navigate_next, ADMIN_NOTIFICATION_SCREEN, context),
                        Divider(
                          color: Colors.blue,
                        ),
                        _button('Usuarios aprobados', Icons.person,
                            Icons.navigate_next, APPROVED_USERS, context),
                        Divider(
                          color: Colors.blue,
                        ),
                        _button('Usuarios pendientes', Icons.person_outline,
                            Icons.navigate_next, PENDING_USERS, context),
                        Divider(
                          color: Colors.blue,
                        ),
                        _button('Foro', Icons.chat_bubble_outline,
                            Icons.navigate_next, ADMIN_FORUM_SCREEN, context),
                        Divider(
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Drawer
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                SizedBox(height: 30),
                _button('Noticias', Icons.notifications_none,
                    Icons.navigate_next, ADMIN_NOTIFICATION_SCREEN, context),
                Divider(
                  color: Colors.blue,
                ),
                _button('Usuarios aprobados', Icons.person, Icons.navigate_next,
                    APPROVED_USERS, context),
                Divider(
                  color: Colors.blue,
                ),
                _button('Usuarios pendientes', Icons.person_outline,
                    Icons.navigate_next, PENDING_USERS, context),
                Divider(
                  color: Colors.blue,
                ),
                _button('Foro', Icons.chat_bubble_outline, Icons.navigate_next,
                    ADMIN_FORUM_SCREEN, context),
                Divider(
                  color: Colors.blue,
                ),
                SizedBox(height: 30),
                //Logout button
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40),
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
                      'Cerrar Sesion',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                  ),
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

Widget drawerData(String text, IconData leadingicon, IconData icon,
    String routeName, BuildContext context) {
  return ListTile(
    leading: CircleAvatar(
      child: Icon(
        leadingicon,
        color: Colors.blue,
        size: 30,
      ),
      backgroundColor: Colors.white,
    ),
    title: Text(text),
    trailing: Icon(icon),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
  );
}

Widget _button(String text, IconData leadingicon, IconData icon,
    String routeName, BuildContext context) {
  return ListTile(
    leading: CircleAvatar(
      child: Icon(
        leadingicon,
        color: Colors.blue,
        size: 30,
      ),
      // radius: 25,
      // backgroundImage: AssetImage(image),
      backgroundColor: Colors.white,
    ),
    title: Text(text),
    trailing: Icon(icon),
    onTap: () {
      Navigator.of(context).pushNamed(routeName);
    },
  );
}
