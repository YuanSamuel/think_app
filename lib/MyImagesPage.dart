import 'package:flutter/material.dart';

class MyImagesPage extends StatefulWidget {
  MyImagesPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyImagesPageState createState() => _MyImagesPageState();
}

class _MyImagesPageState extends State<MyImagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Image"),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int i) {
            return RaisedButton(
                child: Image(
                  image: Image.asset('Images/img.png').image,
                  height: 50,
                ),
                onPressed: () {});
          },
        ));
  }
}
