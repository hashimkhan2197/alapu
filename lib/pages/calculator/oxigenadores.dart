import 'package:alapu/pages/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class OxigenadoresPicture extends StatefulWidget {
  OxigenadoresPicture({Key key}) : super(key: key);

  @override
  _OxigenadoresPictureState createState() => _OxigenadoresPictureState();
}

class _OxigenadoresPictureState extends State<OxigenadoresPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
            imageProvider: AssetImage("assets/tablepic.jpeg"),
          )
      ),
    );
  }
}