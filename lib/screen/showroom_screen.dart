import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';

import 'package:flutter_sogreat_application/screen/show_list_showroom_all.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';

class ShowRoomScreen extends StatefulWidget {
  final GarageModel garageModel;
   ShowRoomScreen({Key key, this.garageModel,}) : super(key: key);

  @override
  _ShowRoomScreenState createState() => _ShowRoomScreenState();
}

class _ShowRoomScreenState extends State<ShowRoomScreen> {
  Widget currentWidget;  
  String idShowroom;

@override
  void initState() {
    super.initState();
    currentWidget = ShowListShowroomAll();

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
        appBar: AppBar(title: MyStyle().showTitle("SHOWROOM"),
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
