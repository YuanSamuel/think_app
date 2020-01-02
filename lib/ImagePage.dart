import 'dart:io';

import 'package:flutter/material.dart';
import 'package:think_app/EditPage.dart';

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
          Container(
            height: 500,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Image(
                image: widget.image.image,
              ),
              Icon(
                Icons.arrow_forward,
                size: 100,
              ),
              Image(
                image: Image.asset('Images/img.png').image,
                width: 250,
              ),
            ],
          ),),
          Column(
            children: <Widget>[
              Text(
                "Originator: 0x1234sknvhues",
              ),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                child: Text("Edit Image Mask", style: TextStyle(
                    color: Colors.white
                ),),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPage(image: widget.image,)),
                  );
                },
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
