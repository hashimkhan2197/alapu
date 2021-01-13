import 'package:alapu/alapAdminSection/pages/admin_panel/documentPicDisplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminSectionDocuments extends StatefulWidget {
  final DocumentSnapshot userSnapshot;
  AdminSectionDocuments(this.userSnapshot);

  @override
  _AdminSectionDocumentsState createState() => _AdminSectionDocumentsState();
}

class _AdminSectionDocumentsState extends State<AdminSectionDocuments> {

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
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    //alap logo
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
                      height: 100,
                      child: Image(image: AssetImage('assets/alap_logo.png')),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //documents heading and icon
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/documents.png'),
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Documentos',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),


                    ///Display List of all files
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            snapshot.data['identityDoc'] != ""
                                ? GestureDetector(
                              child: docs(
                                icon: Icons.picture_as_pdf,
                                documentName:
                                'Documento de Identidad',
                                icon2: Icons.check_circle,
                                iconcolor: Colors.green,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return AdminSectionDocumentPicDisplay(
                                              snapshot.data['identityDoc']);
                                        }));
                              },
                            )
                                : docs(
                              icon: Icons.picture_as_pdf,
                              documentName:
                              'Documento de Identidad',
                              icon2: Icons.cancel,
                              iconcolor: Colors.red,
                            ),
                            if(snapshot.data['noaplica']!=null && snapshot.data['noaplica'] == true && snapshot.data['tituloDoc'] == "")
                              docs2(
                                icon: Icons.school,
                                documentName:
                                'Título Universitario',
                                icon2: Icons.check_circle,
                                iconcolor: Colors.green,
                              ),
                            if(snapshot.data['noaplica']!=null && snapshot.data['noaplica'] == false && snapshot.data['tituloDoc'] == "")
                              docs(
                                icon: Icons.school,
                                documentName: 'Título Universitario',
                                icon2: Icons.cancel,
                                iconcolor: Colors.red,
                              ),
                            if(snapshot.data['noaplica']==null && snapshot.data['tituloDoc'] == "")
                              docs(
                                icon: Icons.school,
                                documentName: 'Título Universitario',
                                icon2: Icons.cancel,
                                iconcolor: Colors.red,
                              ),
                            if(snapshot.data['tituloDoc'] != "")
                              GestureDetector(
                                child: docs(
                                  icon: Icons.school,
                                  documentName:
                                  'Titulo Universitario',
                                  icon2: Icons.check_circle,
                                  iconcolor: Colors.green,
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return AdminSectionDocumentPicDisplay(
                                                snapshot.data['tituloDoc']);
                                          }));
                                },
                              ),


                            snapshot.data['laboralDoc'] != ""
                                ? GestureDetector(
                              child: docs(
                                icon: Icons.work,
                                documentName: 'Constancia Laboral',
                                icon2: Icons.check_circle,
                                iconcolor: Colors.green,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return AdminSectionDocumentPicDisplay(
                                              snapshot.data['laboralDoc']);
                                        }));
                              },
                            )
                                : docs(
                              icon: Icons.work,
                              documentName: 'Constancia Laboral',
                              icon2: Icons.cancel,
                              iconcolor: Colors.red,
                            ),
                            snapshot.data['otrosDoc'] != "" &&
                                snapshot.data['otrosDoc'] != null
                                ? GestureDetector(
                              child: docs(
                                icon: Icons.work,
                                documentName: 'Otros Documentos',
                                icon2: Icons.check_circle,
                                iconcolor: Colors.green,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return AdminSectionDocumentPicDisplay(
                                              snapshot.data['otrosDoc']);
                                        }));
                              },
                            )
                                : docs(
                              icon: Icons.work,
                              documentName: 'Otros Documentos',
                              icon2: Icons.cancel,
                              iconcolor: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),



                    SizedBox(
                      height: 50,
                    ),

                    //reruirment note
//                    Center(
//                      child: Padding(
//                        padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
//                        child: Container(
//                          width: 300,
//                          height: 200,
//                          child: Column(
//                            children: <Widget>[
//                              Text(
//                                'Requerimientos',
//                                style: TextStyle(
//                                    fontSize: 25, fontWeight: FontWeight.bold),
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              Text(
//                                  'Con la finalidad de autentificar su Identidad y confirmar sus capacidades Profisionales necesitamos que nos envielos siguients documentos')
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
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

Widget docs({IconData icon, documentName, IconData icon2, Color iconcolor}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 20,
      margin: EdgeInsets.only(top: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.blue,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                documentName,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                icon2,
                color: iconcolor,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget docs2({IconData icon, documentName, IconData icon2, Color iconcolor}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 25,
      margin: EdgeInsets.only(top: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.blue,
                size: 30,
              ),
              SizedBox(
                width: 17,
              ),
              Text(
                documentName,
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                icon2,
                color: iconcolor,
              ),

              FlatButton(
                  child: Text(
                    "no aplica",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                  onPressed: () {
                  },
//                    padding: EdgeInsets.all(2),
                  splashColor: Colors.blue)
            ],
          ),
        ],
      ),
    ),
  );
}

Widget selectdocuments({IconData icon, docName}) {
  return Row(
    children: <Widget>[
      Icon(
        icon,
        color: Colors.blue,
      ),
      SizedBox(
        width: 10,
      ),
      Text(docName)
    ],
  );
}
