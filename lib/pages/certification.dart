import 'package:alapu/pages/pdf_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Certification extends StatefulWidget {
  Certification({Key key}) : super(key: key);

  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {


  bool _prefloading = false;
  String currentUserId;
  String urlPDFPath = "";
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      FirebaseUser authResult = await FirebaseAuth.instance.currentUser();
//      getFileFromUrl("https://firebasestorage.googleapis.com/v0/b/alap-d3940.appspot.com/o/Certificates%2FPMC%20-%20Roll%20No%20Slip.pdf?alt=media&token=60aa18da-7218-4437-9609-6db028b5aa92").then((f) {
////        setState(() {
////          urlPDFPath = f.path;
////          print(urlPDFPath);
////        });
//        urlPDFPath = f.path;
//        print(urlPDFPath);
//      });

      setState(() {
        currentUserId = authResult.uid;
        _prefloading = false;
        print(currentUserId);
      });
    });
    super.initState();
  }

  Future<String> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);

      urlPDFPath = urlFile.path;
      print(urlPDFPath);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PdfViewPage(path: urlPDFPath,)),
      );
      return urlPDFPath;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }



  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
          ):StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(currentUserId).snapshots(),
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
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 100,
                      child: Image(image: AssetImage('assets/alap_logo.png')),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    ///user profile picture, name, member id etc
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(snapshot.data['userImage']),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  if(snapshot.data['certi']!=null && snapshot.data['certi']==true)
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/certification.png'),
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if(snapshot.data['certi']!=null && snapshot.data['certi']==true)
                                  Text('Certificado'),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if(snapshot.data['certi'] ==null || snapshot.data['certi'] == false)
                              Text('No Certificado'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                height: 25,
                                color: Colors.blue[800],
                                child: Text(
                                  '  Miembro desde:  ',
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (snapshot.data['certificationdate'] != null)
                              Container(
                                width: 148,
                                height: 25,
                                color: Colors.grey[200],
                                child: Text(
                                  snapshot.data['certificationdate'],
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              if (snapshot.data['certificationdate'] == null)
                                Container(
                                  width: 148,
                                  height: 25,
                                  color: Colors.grey[200],
                                  child: Text(
                                    '',
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    ///user uplaod picture
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            child: CircleAvatar(
                              child: _image == null
                                  ? Icon(
                                      Icons.school,
                                      size: 50,
                                    )
                                  : Image.file(_image),
                              radius: 50,
                              backgroundColor: HexColor("#F2F2F5"),
                            ),
                            onTap: (){},
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: <Widget>[
                              Text('Número de Membresía: '),
                              SizedBox(
                                height: 10,
                              ),
                              Text(snapshot.data['nombre'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Apellido: '+ snapshot.data['apellido'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ///input feilds
//                _textInput(hint: "Email", icon: Icons.email),
//                _textInput(hint: "Nacionalidad", icon: Icons.flag),
//                _textInput(hint: "Phone Number", icon: Icons.call),
                    _uceInput(
                      hint: snapshot.data['uce'],
                    ),
//                _textInput(hint: "Región", icon: Icons.location_city),

                    ///alap id button
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'ID ALAP',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if(snapshot.data['certificatelink'] != null){
                              getFileFromUrl(snapshot.data['certificatelink']);
                            }

                          }),
                    )
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
      ],
    );
  }
}

Widget _textInput({controller, hint, icon}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: Container(
      height: 60,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: HexColor("#F2F2F5"),
          // color:Colors.g
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ]),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    ),
  );
}

Widget _uceInput({
  controller,
  hint,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: HexColor("#F2F2F5"),
          // color:Colors.g
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ]),
      padding: EdgeInsets.all(12),
      child: Text(
        hint,
      ),
    ),
  );
}
