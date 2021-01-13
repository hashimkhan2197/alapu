import 'dart:io';

import 'package:alapu/pages/admin_panel/documentPicDisplay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Documents extends StatefulWidget {
  Documents({Key key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  var _value = 1;

  bool _prefloading = false;
  String currentUserId;

  @override
  void initState() {
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

  ///uploading doc images
  ///image picker
  File _image;
  String _imageUrl = "";
  bool signupLoading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });

      final FirebaseStorage _storgae =
          FirebaseStorage(storageBucket: 'gs://alap-d3940.appspot.com/');
      StorageUploadTask uploadTask;
      String filePath = '${DateTime.now()}.png';
      uploadTask = _storgae.ref().child(filePath).putFile(image);
      uploadTask.onComplete.then((_) async {
        String url1 = await uploadTask.lastSnapshot.ref.getDownloadURL();
        print(url1);
        _imageUrl = url1;
        if (_value == 2) {
          Firestore.instance
              .collection('users')
              .document(currentUserId)
              .updateData({'identityDoc': url1});
        } else if (_value == 3) {
          Firestore.instance
              .collection('users')
              .document(currentUserId)
              .updateData({'tituloDoc': url1});
        } else if (_value == 4) {
          Firestore.instance
              .collection('users')
              .document(currentUserId)
              .updateData({'laboralDoc': url1});
        } else if (_value == 5) {
          Firestore.instance
              .collection('users')
              .document(currentUserId)
              .updateData({'otrosDoc': url1});
        }
      });
    }
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
          ),
          body: _prefloading == true
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )
              : StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .document(currentUserId)
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

                          ///alap logo
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
                            height: 100,
                            child: Image(
                                image: AssetImage('assets/alap_logo.png')),
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
                                  backgroundImage:
                                      AssetImage('assets/documents.png'),
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Documentos',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),

                          ///dropdown button for choosing documents
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: DropdownButton(
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            'Carga tus documentos',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )
                                        ],
                                      ),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: selectdocuments(
                                        icon: Icons.picture_as_pdf,
                                        docName: 'Documento de Identidad',
                                      ),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                        child: selectdocuments(
                                          icon: Icons.school,
                                          docName: 'Título Universitario',
                                        ),
                                        value: 3),
                                    DropdownMenuItem(
                                        child: selectdocuments(
                                          icon: Icons.work,
                                          docName: 'Constancia Laboral',
                                        ),
                                        value: 4),
                                    DropdownMenuItem(
                                        child: selectdocuments(
                                          icon: Icons.work,
                                          docName: 'Otros Documentos',
                                        ),
                                        value: 5),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                    if (value != 1) {
                                      getImage();
                                    }
                                  }),
                            ),
                          ),

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
                                              return DocumentPicDisplay(
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
                                    docs2(
                                    icon: Icons.school,
                                    documentName: 'Título Universitario',
                                    icon2: Icons.cancel,
                                    iconcolor: Colors.red,
                                  ),
                                  if(snapshot.data['noaplica']==null && snapshot.data['tituloDoc'] == "")
                                    docs2(
                                      icon: Icons.school,
                                      documentName: 'Título Universitario',
                                      icon2: Icons.cancel,
                                      iconcolor: Colors.red,
                                    ),
                                  if(snapshot.data['tituloDoc'] != "")
                                    GestureDetector(
                                      child: docs2(
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
                                                  return DocumentPicDisplay(
                                                      snapshot.data['tituloDoc']);
                                                }));
                                      },
                                    ),

//                                  snapshot.data['tituloDoc'] != ""
//                                      ?
//                                        GestureDetector(
//                                          child: docs2(
//                                            icon: Icons.school,
//                                            documentName:
//                                                'Titulo Universitario',
//                                            icon2: Icons.check_circle,
//                                            iconcolor: Colors.green,
//                                          ),
//                                          onTap: () {
//                                            Navigator.push(context,
//                                                MaterialPageRoute(
//                                                    builder: (context) {
//                                              return DocumentPicDisplay(
//                                                  snapshot.data['tituloDoc']);
//                                            }));
//                                          },
//                                        )
//                                      : docs2(
//                                          icon: Icons.school,
//                                          documentName: 'Titulo Universitario',
//                                          icon2: Icons.cancel,
//                                          iconcolor: Colors.red,
//                                        ),
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
                                              return DocumentPicDisplay(
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
                                              return DocumentPicDisplay(
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
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                              child: Container(
                                width: 300,
                                height: 200,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Requerimientos',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Con la finalidad de verificar su identidad y confirmar sus credenciales profesionales, por favor cargar los documentos solicitados y así poder completar su perfil')
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                      Firestore.instance
                          .collection('users')
                          .document(currentUserId)
                          .updateData({'noaplica': true});
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
}
