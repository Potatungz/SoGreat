import 'package:flutter/material.dart';

class BuildGarageScreen extends StatefulWidget {
  @override
  _BuildGarageScreenState createState() => _BuildGarageScreenState();
}

class _BuildGarageScreenState extends State<BuildGarageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(child: Text("Build Garage Screen")),
    );
  }
}
