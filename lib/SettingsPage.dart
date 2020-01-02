import 'package:flutter/material.dart';
import 'package:think_app/MyImagesPage.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SettingsPageState createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            value: switch1,
            title: Text("Notifications"),
            onChanged: (value) {
              print(value);
              setState(() {
                switch1 = value;
              });
            },
          ),
          Divider(),
          SwitchListTile(
            value: switch2,
            title: Text("Notifications2"),
            onChanged: (value) {
              setState(() {
                switch2 = value;
              });
            },
          ),
          Divider(),
          SwitchListTile(
            value: switch3,
            title: Text("Notifications3"),
            onChanged: (value) {
              setState(() {
                switch3 = value;
              });
            },
          ),
          Divider(),
          ListTile(
            title: Text("Edit my Image Preferences"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyImagesPage()),
              );
            },
          )
        ],
      ),
    );
  }
}