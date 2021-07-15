import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/showroom_screen.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BuildGarageScreen extends StatefulWidget {
  final UserModel userModel;
  BuildGarageScreen({Key key, this.userModel}) : super(key: key);
  @override
  _BuildGarageScreenState createState() => _BuildGarageScreenState();
}

class _BuildGarageScreenState extends State<BuildGarageScreen> {
  String idUser, nameGarage;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    readGarageName();
  }

  Future<Null> readGarageName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    nameGarage = preferences.getString("NameGarage");
    idUser = preferences.getString("id");

    String url =
        "${MyConstant().domain}/SoGreat/getUserWhereId.php?isAdd=true&id=$idUser";

    Response response = await Dio().get(url);
    print("response ===>> $response");

    var result = json.decode(response.data);
    print("result ===>> $result");

    for (var map in result) {
      print("map ==>> $map");
      setState(() {
        userModel = UserModel.fromJson(map);
        nameGarage = userModel.nameGarage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size.height;
    var notifySize = MediaQuery.of(context).padding.top;
    var appBarSize = AppBar().preferredSize.height;
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
      body: SingleChildScrollView(
        child: Container(
          height: pageSize - (appBarSize + notifySize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: Text("Create your garage",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: TextField(
                          keyboardType: TextInputType.name,
                          onChanged: (value) => nameGarage = value.trim(),
                          autofocus: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: nameGarage == ""
                                  ? "Enter Your Garage Name"
                                  : "$nameGarage",
                              hintStyle: TextStyle(color: Colors.grey)),
                        )),
                      ),
                    ]),
              ),
              Container(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyStyle().primaryColor),
                    child: FlatButton(
                        onPressed: () {
                          print("Garage Name = $nameGarage");
                          if (nameGarage?.isEmpty ?? true) {
                            normailDialog(context, "Please insert garage name");
                          } else {
                            checkGarage();
                          }
                        },
                        child: Text(
                          "Build",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffe6e6e6)),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          print("Tap to Cancel");
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Color(0xffc8c8c8),
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> checkGarage() async {
    String url =
        "${MyConstant().domain}/SoGreat/getUserWhereNameGarage.php?isAdd=true&NameGarage=$nameGarage";

    try {
      Response response = await Dio().get(url);
      if (response.toString() == "null") {
        createGarage();
      } else {
        normailDialog(context, "$nameGarage Already has a duplicate garage");
      }
    } catch (e) {}
  }

  Future<Null> createGarage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String url =
        "${MyConstant().domain}/SoGreat/updateUserWhereId.php?isAdd=true&id=$idUser&NameGarage=$nameGarage";
    try {
      Response response = await Dio().get(url);
      print("res = $response");

      if (response.toString() == "true") {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => ShowRoomScreen());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else {
        normailDialog(context, "Can't to Create Garage. Try Again");
      }
    } catch (e) {}
  }
}
