import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPanelAddNotification extends StatefulWidget {
  AdminPanelAddNotification({Key key}) : super(key: key);

  @override
  _AdminPanelAddNotificationState createState() => _AdminPanelAddNotificationState();
}

class _AdminPanelAddNotificationState extends State<AdminPanelAddNotification> {

  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: '');


  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Agregar Noticia',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 50),
                 //alap logo
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 100,
                  child: Image(image: AssetImage('assets/alap_logo.png')),
                ),
                SizedBox(height: 50),
                //notification title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Título',
                        hintStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //notification Description
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Descripción...',
                        hintStyle: TextStyle(fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 30, right: 30),
                    color: Colors.blue[800],
                    textColor: Colors.white,
                    child: Text(
                      'Agregar Noticia',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      if(titleController.text == ''){
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Colors.red[400],
                                  )),
                              title: Text("Noticias"),
                              content:
                              Text("El título no debe estar vacío."),
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
                      }else{
                        Firestore.instance.collection('notifications').add({
                          'title': titleController.text.trim(),
                          'description': descriptionController.text.trim(),
                          'time': DateTime.now().toIso8601String()
                        }).then((value) {
                          Navigator.pop(context);
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
                                title: Text("Error!"),
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
                      }

                    },
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
