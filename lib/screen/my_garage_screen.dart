import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/home.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/widget/show_my_garage.dart';

class MyGarageScreen extends StatefulWidget {
  final UserModel userModel;
  MyGarageScreen({
    Key key,
    this.userModel,
  }) : super(key: key);

  @override
  _MyGarageScreenState createState() => _MyGarageScreenState();
}

class _MyGarageScreenState extends State<MyGarageScreen> {
  UserModel userModel;
  String nameGarage;
  Widget currentWidget;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    currentWidget = ShowMyGarage(userModel: userModel);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ShaderMask(
        shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black38, Colors.transparent]).createShader(rect),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage("images/garage.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ))),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(color: Colors.black.withOpacity(0)),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: MyStyle().showTitle("My Garage"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Home(),
              );
              Navigator.push(context, route);
            },
          ),
        ),
        body: currentWidget,
      ),
    ]);
  }
}
