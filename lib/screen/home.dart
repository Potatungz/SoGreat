import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/build_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/edit_account.dart';
import 'package:flutter_sogreat_application/screen/find_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/my_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/show_list_showroom_all.dart';
import 'package:flutter_sogreat_application/screen/showroom_screen.dart';
import 'package:flutter_sogreat_application/screen/signin.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File file;
  String nameUser, urlImage, id, phone,garageName;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    readCurrentInfo();
  }

  Future<Null> readCurrentInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    nameUser = preferences.getString("Name");
    urlImage = preferences.getString("URLImage");
    phone = preferences.getString("Phone");
    garageName = preferences.getString("GarageName");
    id = preferences.getString("id");

    String url =
        "${MyConstant().domain}/SoGreat/getUserWhereId.php?isAdd=true&id=$id";

    Response response = await Dio().get(url);
    print("response ===>> $response");

    var result = json.decode(response.data);
    print("result ===>> $result");

    for (var map in result) {
      print("map ==>> $map");
      setState(() {
        userModel = UserModel.fromJson(map);
        nameUser = userModel.name;
        urlImage = userModel.urlImage;
        phone = userModel.phone;
        garageName = userModel.nameGarage;
      });
    }
  }

  Future<Null> signOutProcess() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    //exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/garage.png"),
              fit: BoxFit.cover,
            ),
          ),
        ), BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(color: Colors.black.withOpacity(0)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset("images/logo.png"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myGarageButton(),
                  buildButton(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showroomButton(),
                  findButton(),
                ],
              )
            ],
          ),
          drawer: showDrawer(context),
        ),
      ],
    );
  }

  Container findButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: 145.0,
      height: 145.0,
      decoration: BoxDecoration(
          color: MyStyle().primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10.0, spreadRadius: 1.0)
          ]),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FindGarageScreen();
          }));
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
                size: 40.0,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Find",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Container showroomButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: 145.0,
      height: 145.0,
      decoration: BoxDecoration(
          color: MyStyle().primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10.0, spreadRadius: 1.0)
          ]),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ShowRoomScreen();
          }));
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Icon(
                Icons.car_repair,
                color: Colors.white,
                size: 40.0,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Showroom",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Container buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: 145.0,
      height: 145.0,
      decoration: BoxDecoration(
          color: MyStyle().primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10.0, spreadRadius: 1.0)
          ]),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BuildGarageScreen();
          }));
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Icon(Icons.settings, color: Colors.white, size: 40.0),
            ],
          ),
          Row(
            children: [
              Text("Build",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0)),
            ],
          )
        ]),
      ),
    );
  }

  Container myGarageButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: 145.0,
      height: 145.0,
      decoration: BoxDecoration(
          color: MyStyle().primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10.0, spreadRadius: 1.0)
          ]),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyGarageScreen();
          }));
          
          
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Icon(Icons.home, color: Colors.white, size: 40.0),
            ],
          ),
          Row(
            children: [
              Text("My Garage",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0)),
            ],
          )
        ]),
      ),
    );
  }

  Theme showDrawer(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black87.withOpacity(0.6),
      ),
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            Container(
              height: 200.0,
              child: DrawerHeader(
                  child: Column(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                        child: urlImage == null
                            ? Image.asset(
                                "images/avatar_blank.png",
                                fit: BoxFit.cover,
                              )
                            // : Image.network("${MyConstant().domain}$urlImage",
                            : Image.network(
                                "${MyConstant().domain}$urlImage",
                                fit: BoxFit.cover,
                              )),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.grey,
                  //   radius: 60.0,
                  //   child: Text('Image'),
                  // ),
                  SizedBox(height: 10.0),
                  Text(nameUser == null ? "Guest" : "$nameUser",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600))
                ],
              )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //homeMenu(),
                accountMenu(),
                showroomMenu(),
                findMenu(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                logOutMenu(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile logOutMenu() => ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        title: Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SignIn();
          }));
          signOutProcess();
        },
      );

  ListTile findMenu() => ListTile(
        leading: Icon(Icons.search, color: Colors.white),
        title: Text("Find", style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FindGarageScreen();
          }));
        },
      );

  ListTile showroomMenu() => ListTile(
        leading: Icon(Icons.home, color: Colors.white),
        title: Text("My Garage", style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ShowListShowroomAll();
          }));
        },
      );

  ListTile accountMenu() => ListTile(
        leading: Icon(
          Icons.account_box,
          color: Colors.white,
        ),
        title: Text("Account", style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditAccount();
          })).then((value) => readCurrentInfo());
        },
      );

  ListTile homeMenu() => ListTile(
        title: Text("Home", style: TextStyle(color: Colors.white)),
        onTap: () {},
      );
}
