import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class AdminSectionDocumentPicDisplay extends StatefulWidget {

  final String url;
  AdminSectionDocumentPicDisplay(this.url);

  @override
  _AdminSectionDocumentPicDisplayState createState() => _AdminSectionDocumentPicDisplayState();
}

class _AdminSectionDocumentPicDisplayState extends State<AdminSectionDocumentPicDisplay> {
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