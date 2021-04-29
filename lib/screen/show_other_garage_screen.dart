import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/widget/show_other_garage.dart';

class ShowOtherGarageScreen extends StatefulWidget {
  final UserModel userModel;
ShowOtherGarageScreen({Key key, this.userModel,}) : super(key: key);
  @override
  _ShowOtherGarageScreenState createState() => _ShowOtherGarageScreenState();
}

class _ShowOtherGarageScreenState extends State<ShowOtherGarageScreen> {
  UserModel userModel;
String nameGarage;
Widget currentWidget;

  @override
  void initState() {
   
    super.initState();
    userModel = widget.userModel;
    currentWidget = ShowOtherGarage(userModel: userModel);
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
        appBar: AppBar(title: MyStyle().showTitle("${userModel.nameGarage}"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),body: currentWidget,
       
      ),
    ]);
  }
}