import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';

class FindGarageScreen extends StatefulWidget {
  @override
  _FindGarageScreenState createState() => _FindGarageScreenState();
}

class _FindGarageScreenState extends State<FindGarageScreen> {
double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
      body: MyStyle().buildBackground(screenWidth, screenHeight,),
    );
  }
}
