import 'dart:io';

import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final Image image;

  ImagePage({Key key, @required this.image}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image #" + widget.image.hashCode.toString()),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: widget.image.image,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "Originator: 0x1234sknvhues",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
