import 'package:alapu/alapAdminSection/pages/Forum/forum.dart';
import 'package:alapu/alapAdminSection/pages/admin_panel/add_notification.dart';
import 'package:alapu/alapAdminSection/pages/admin_panel/adminPanel_menu.dart';
import 'package:alapu/alapAdminSection/pages/admin_panel/approved_user_list.dart';
import 'package:alapu/alapAdminSection/pages/admin_panel/pending_user_list.dart';
import 'package:alapu/alapAdminSection/pages/notification_page.dart';
import 'package:alapu/alapAdminSection/widgets/constant.dart';
import 'package:alapu/pages/Forum/forum.dart';
import 'package:alapu/pages/Forum/forum_detail.dart';
import 'package:alapu/pages/calculator/calculator_input.dart';
import 'package:alapu/pages/calculator/license_page.dart';
import 'package:alapu/pages/calculator/calculatornextinput.dart';
import 'package:alapu/pages/calculator/results.dart';
import 'package:alapu/pages/certification.dart';
import 'package:alapu/pages/documents_page.dart';
import 'package:alapu/pages/login_page.dart';
import 'package:alapu/pages/menu_page.dart';
import 'package:alapu/widgets/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/my_profile.dart';
import 'pages/documents_page.dart';
import 'pages/notification_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALAP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return Menu();
          }
          return LoginPage();
        },
      ),

      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) => SplashPage(),
        MAIN_SCREEN: (BuildContext context) => Menu(),
        PROFILE_SCREEN: (BuildContext context) => MyProfile(),
        NOTIFICATION_SCREEN: (BuildContext context) => Notifications(),
        DOCUMENT_SCREEN: (BuildContext context) => Documents(),
        CERTIFICATION_SCREEN: (BuildContext context) => Certification(),
        FORUM_SCREEN: (BuildContext context) => ForumPage(),
        LICENSE_SCREEN: (BuildContext context) => CalculatorLicense(),
        CALCULATOR_INPUT: (BuildContext context) => CalculatorInput(),

        //Admin Section Routes

        ADMIN_NOTIFICATION_SCREEN: (BuildContext context) => AdminSectionNotifications(),
        ADMIN_FORUM_SCREEN: (BuildContext context) => AdminSectionForumPage(),
        ADMIN_PANEL_MENU: (BuildContext context) => AdminPanelMenu(),
        APPROVED_USERS: (BuildContext context) => ApprovedUserList(),
        PENDING_USERS: (BuildContext context) => PendingUserList(),
        ADD_NOTICARION: (BuildContext context) => AdminPanelAddNotification(),

      },
    );
  }
}
