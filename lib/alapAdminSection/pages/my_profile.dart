import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AdminSectionMyProfile extends StatefulWidget {
  final DocumentSnapshot userSnapshot;
  final bool activeBool;
  AdminSectionMyProfile(this.userSnapshot,this.activeBool);
  @override
  _AdminSectionMyProfileState createState() => _AdminSectionMyProfileState();
}

class _AdminSectionMyProfileState extends State<AdminSectionMyProfile> {
  var profilecompleted = 0;
  bool activeStatus = false;


  @override
  void initState() {
    activeStatus = widget.activeBool;

//    profilecompleted = 0;
//    if(widget.userSnapshot.data['identityDoc']!=""){
//      profilecompleted+=1;
//    }
//    if(widget.userSnapshot.data['laboralDoc']!=""){
//      profilecompleted+=1;
//    }
//    if(widget.userSnapshot.data['tituloDoc']!=""){
//      profilecompleted+=1;
//    }else if (widget.userSnapshot.data['noaplica']!= null && widget.userSnapshot.data['noaplica'] == true){
//      profilecompleted+=1;
//    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            iconTheme: IconThemeData(color: Colors.red),
          ),
          body: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(widget.userSnapshot.documentID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center();
              }

              profilecompleted = 0;
              if(snapshot.data['identityDoc']!=""){
                profilecompleted+=1;
              }
              if(snapshot.data['laboralDoc']!=""){
                profilecompleted+=1;
              }
              if(snapshot.data['tituloDoc']!=""){
                profilecompleted+=1;
              } else if (widget.userSnapshot.data['noaplica']!= null && snapshot.data['noaplica'] == true){
                profilecompleted+=1;
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        //alap logo
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
                          height: 130,
                          child: Image(
                              image: AssetImage('assets/alap_logo.png')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //user profile picture
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 55,
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
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    'Membresía # '+snapshot.data['memberSince'],
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //user information
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _myProfileData(
                                  //icon: Icons.person,
                                    heading: "Nombre:",
                                    data: snapshot.data['nombre']),
                                _myProfileData(
                                  //icon: Icons.person_add,
                                    heading: "Apellido:",
                                    data: snapshot.data['apellido']),
                                _myProfileData(
                                  //icon: Icons.email,
                                    heading: "E-Mail:",
                                    data: snapshot.data['email']),
                                _myProfileData(
                                  //icon: Icons.phone,
                                    heading: "Teléfono:",
                                    data: snapshot.data['phone']),
                                _myProfileData(
                                  //icon: Icons.flag,
                                    heading: "País:",
                                    data: snapshot.data['nationality']),
                                _myProfileData(
                                  //icon: Icons.add_location,
                                    heading: "Región:",
                                    data: snapshot.data['region']),
                                _myProfileData(
                                  //icon: Icons.check,
                                    heading: "Certificación:",
                                    data: snapshot.data['certi'] != null && snapshot.data['certi'] == true?'Certificado':'') ,
                                _myProfileData(heading: "Estatus:", data: activeStatus==true ? 'Aprobado': 'Pendiente'),
                              ],
                            ),
                          ),
                        ),

                        // percentage indicator shwo the progress of information completion
                        if(profilecompleted==0)
                          CircularPercentIndicator(
                            progressColor: Colors.green,
                            animation: true,
                            percent: 0.0,
                            radius: 130,
                            lineWidth: 15,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              '0.0%',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        if(profilecompleted==1)
                          CircularPercentIndicator(
                            progressColor: Colors.green,
                            animation: true,
                            percent: 0.33,
                            radius: 130,
                            lineWidth: 15,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              '33.3%',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        if(profilecompleted==2)
                          CircularPercentIndicator(
                            progressColor: Colors.green,
                            animation: true,
                            percent: 0.66,
                            radius: 130,
                            lineWidth: 15,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              '66.6%',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        if(profilecompleted==3)
                          CircularPercentIndicator(
                            progressColor: Colors.green,
                            animation: true,
                            percent: 1.0,
                            radius: 130,
                            lineWidth: 15,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              '100%',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
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

Widget _myProfileData({IconData icon, heading, data}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                heading,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(width: 30.0),
              Text(data)
            ],
          ),
        ],
      ),
    ),
  );
}
