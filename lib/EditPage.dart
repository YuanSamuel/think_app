import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Image image;

  EditPage({Key key, @required this.image}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _EditPageState createState() => _EditPageState();
}

class MaskEditor extends CustomPainter {
  final List<Offset> offsets;
  final double strokeW;

  MaskEditor(this.offsets, this.strokeW) : super();


  @override
  void paint(ui.Canvas canvas, Size size) {
    ui.Paint paint = new Paint()
      ..color = Colors.white
      ..isAntiAlias = true
      ..strokeWidth = strokeW;
//    int past = 0;
//    for (int i = 0; i < offsets.length; i++) {
//      if (offsets[i] == null) {
//        if (past == i) {
//          past++;
//          continue;
//        }
//        canvas.drawPoints(PointMode.polygon, offsets.sublist(past, i), paint);
//        past = i + 1;
//      }
//    }
//    if (past != offsets.length)
//      canvas.drawPoints(PointMode.polygon, offsets.sublist(past), paint);
    for (int i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        canvas.drawLine(offsets[i], offsets[i + 1], paint);
      }
      if (offsets[i] != null && offsets[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [offsets[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _EditPageState extends State<EditPage> {
  final _offsets = <Offset>[];
  double strokeW = 5.0;




  @override
  Widget build(BuildContext context) {
    Image setImg = Image(
      image: widget.image.image,
      width: MediaQuery.of(context).size.width * 0.9,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit the mask"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                25,
                MediaQuery.of(context).size.width * 0.05,
                25),
            child: GestureDetector(
              child: CustomPaint(
                  foregroundPainter: MaskEditor(_offsets, strokeW),
                  child: setImg),
              onPanStart: (details) {
                setState(() {
                  if (details.localPosition.dx >= 0 &&
                      details.localPosition.dx <= setImg.width) {
                    _offsets.add(details.localPosition);
                  } else {
                    _offsets.add(null);
                  }
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  if (details.localPosition.dx >= 0 &&
                      details.localPosition.dx <= setImg.width) {
                    _offsets.add(details.localPosition);
                  } else {
                    _offsets.add(null);
                  }
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _offsets.add(null);
                });
              },
            ),
          ),
          Flexible(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Slider(
                    onChanged: (value) {
                      setState(() {
                        strokeW = value;
                      });
                    },
                    value: strokeW,
                    min: 0.5,
                    max: 10.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child:
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
