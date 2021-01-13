import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AdminSectionCertification extends StatefulWidget {
  final DocumentSnapshot userSnapshot;

  AdminSectionCertification(this.userSnapshot);

  @override
  _AdminSectionCertificationState createState() => _AdminSectionCertificationState();
}

class _AdminSectionCertificationState extends State<AdminSectionCertification> {
  TextEditingController uceController ;
  TextEditingController membershipNumberController;
  TextEditingController membersinceController;


  @override
  void dispose() {
    uceController.dispose();
    membershipNumberController.dispose();
    membersinceController.dispose();
    super.dispose();
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
            iconTheme: IconThemeData(color: Colors.red),
          ),
          body: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(widget.userSnapshot.documentID).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              uceController = TextEditingController(text: snapshot.data['uce']);
              membershipNumberController  = TextEditingController(text: snapshot.data['memberSince']);
              membersinceController  = TextEditingController(text: snapshot.data['certificationdate']);

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
                    _uceInput(hint: 'UCE', controller: uceController),

                    ///input feilds
                _textInput(hint: "Membresía #", icon: Icons.email,controller: membershipNumberController),
                _textInput(hint: "Miembro Desde", icon: Icons.flag,controller: membersinceController),
//                _textInput(hint: "Phone Number", icon: Icons.call),

                    ///alap id button
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 25, 100, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Firestore.instance
                                .collection('users')
                                .document(widget.userSnapshot.documentID)
                                .updateData({
                              'uce': uceController.text.trim(),
                              'memberSince': membershipNumberController.text.trim(),
                              'certificationdate': membersinceController.text.trim()

                                }).then(
                                    (value) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.red[400],
                                        )),
                                    title: Text("Updates"),
                                    content: Text("los cambios se han realizado con éxito."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
//                              uceController.clear();
                            }).catchError((e){
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
                                    content:
                                    Text("Error: por favor revise su conexion a internet."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                          }),
                    ),
                    ///Certificate upload button
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 5, 100, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'ID ALAP',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            ///Getting pdf file from device
                            File file = await FilePicker.getFile(type: FileType.custom);
                            String fileName = '${DateTime.now().toString()}.pdf';

                            ///Saving Pdf to firebase
                            StorageReference reference =  FirebaseStorage.instance.ref().child(fileName);
                            StorageUploadTask uploadTask = reference.putData(file.readAsBytesSync());
                            String url = await (await uploadTask.onComplete).ref.getDownloadURL();


                            Firestore.instance
                                .collection('users')
                                .document(widget.userSnapshot.documentID)
                                .updateData({
                              'certificatelink' : url
                            }).then(
                                    (value) {
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red[400],
                                            )),
                                        title: Text("Updates"),
                                        content: Text("los cambios se han realizado con éxito."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(color: Colors.red[400]),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
//                              uceController.clear();
                                }).catchError((e){
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
                                    content:
                                    Text("Error: por favor revise su conexion a internet."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                          }),
                    ),
                    ///Certification Button
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 5, 100, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'Certificado',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: (){
                            Firestore.instance
                                .collection('users')
                                .document(widget.userSnapshot.documentID)
                                .updateData({
                              'certi': true,
                            }).then(
                                    (value) {
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red[400],
                                            )),
                                        title: Text("Updates"),
                                        content: Text("los cambios se han realizado con éxito."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(color: Colors.red[400]),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
//                              uceController.clear();
                                }).catchError((e){
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
                                    content:
                                    Text("Error: por favor revise su conexion a internet."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                          }),
                    ),
                    ///No Certificado Button
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 5, 100, 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'No Certificado',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          onPressed: (){
                            Firestore.instance
                                .collection('users')
                                .document(widget.userSnapshot.documentID)
                                .updateData({
                              'certi': false,
                            }).then(
                                    (value) {
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Colors.red[400],
                                            )),
                                        title: Text("Updates"),
                                        content: Text("los cambios se han realizado con éxito."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(color: Colors.red[400]),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
//                              uceController.clear();
                                }).catchError((e){
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
                                    content:
                                    Text("Error: por favor revise su conexion a internet."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ));
                            });
                          }),
                    ),
                    SizedBox(height: 20,),

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
//            prefixIcon: Icon(icon),
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
        padding: EdgeInsets.only(left: 10),
        child: TextFormField(
//          initialValue: uce,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          //Normal textInputField will be displayed
          maxLines: 10,
          // when user presses enter it will adapt to it
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
