import 'dart:async';
import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:think_app/ImagePage.dart';
import 'package:think_app/SettingsPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> images = new List<File>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: FabCircularMenu(
        animationDuration: Duration(milliseconds: 500),
        ringColor: Colors.white.withOpacity(0.7),
        ringDiameter: 300,
        ringWidth: 75,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView.builder(
                itemCount: (images.length / 3).ceil(),
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            child: Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    blurRadius:
                                    20.0, // has the effect of softening the shadow
                                    offset: Offset(
                                      0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: images[i * 3] != null
                                  ? Image(
                                  image: Image.file(images[i * 3])
                                      .image)
                                  : Icon(Icons.image),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePage(
                                        image:
                                        Image.file(images[i * 3]))),
                              );
                            },
                          ),
                        ),
                        images.length > i * 3 + 1
                            ? Expanded(
                          child: FlatButton(
                            child: Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    blurRadius:
                                    20.0, // has the effect of softening the shadow
                                    offset: Offset(
                                      0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: images[i * 3 + 1] != null
                                  ? Image(
                                  image: Image.file(images[i * 3 + 1])
                                      .image)
                                  : Icon(Icons.image),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePage(
                                        image:
                                        Image.file(images[i * 3 + 1]))),
                              );
                            },
                          ),
                        )
                            : SizedBox.shrink(),
                        images.length > i * 3 + 2
                            ? Expanded(
                                child: FlatButton(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius:
                                              20.0, // has the effect of softening the shadow
                                          offset: Offset(
                                            0, // horizontal, move right 10
                                            5.0, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: images[i * 3 + 2] != null
                                        ? Image(
                                            image: Image.file(images[i * 3 + 2])
                                                .image)
                                        : Icon(Icons.image),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImagePage(
                                              image:
                                                  Image.file(images[i * 3 + 2]))),
                                    );
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        options: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 25,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.image,
              size: 25,
            ),
            onPressed: () {
              getImageFromGallery();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 25,
            ),
            onPressed: () {
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await uploadFile(image);
    }
    setState(() {
      if (image != null) {
          images.add(image);
      }
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await uploadFile(image);
    }
    setState(() {
      if (image != null) {
        images.add(image);
      }
    });
  }


  Future uploadFile(File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('photos/${Path.basename(image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
  }

}
