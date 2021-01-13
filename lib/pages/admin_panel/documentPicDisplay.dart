import 'package:alapu/pages/menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DocumentPicDisplay extends StatefulWidget {

  final String url;
  DocumentPicDisplay(this.url);

  @override
  _DocumentPicDisplayState createState() => _DocumentPicDisplayState();
}

class _DocumentPicDisplayState extends State<DocumentPicDisplay> {
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
            imageProvider: NetworkImage(widget.url),
          )
      ),
    );
  }
}