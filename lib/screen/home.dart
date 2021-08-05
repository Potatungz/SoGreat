import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/build_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/edit_account.dart';
import 'package:flutter_sogreat_application/screen/my_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/search_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/showroom_screen.dart';
import 'package:flutter_sogreat_application/screen/signin.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File file;
  String nameUser, urlImage, id, phone, garageName;
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

  Widget _landscapeView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset("images/logo.png"),
          ),
        ),
        Container(
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 2, child: myGarageButtonLandscape()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Flexible(flex: 2, child: buildButtonLandscape()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Flexible(flex: 2, child: showroomButtonLandscape()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Flexible(flex: 2, child: findButtonLandscape()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _portraitView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset("images/logo.png"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: myGarageButton()),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Flexible(flex: 2, child: buildButton()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: showroomButton()),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Flexible(flex: 2, child: findButton()),
          ],
        )
      ],
    );
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
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(color: Colors.black.withOpacity(0)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            return SingleChildScrollView(
                child: orientation == Orientation.portrait
                    ? _portraitView()
                    : _landscapeView());
          }),
          drawer: showDrawer(context),
        ),
      ],
    );
  }

  Container findButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.2,
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
            return SearchGarageScreen();
          }));
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 40.0,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "Find",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Container showroomButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.185,
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
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.carAlt,
                  color: Colors.white,
                  size: 36.0,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  "Showroom",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Container buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.185,
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
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.white, size: 40.0),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text("Build",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Container myGarageButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.185,
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
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Icon(Icons.home, color: Colors.white, size: 40.0),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text("My Garage",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Container findButtonLandscape() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.3,
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
            return SearchGarageScreen();
          }));
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  "Find",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                  maxLines: 1,
                  maxFontSize: 18.0,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Container showroomButtonLandscape() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.3,
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
              Expanded(
                flex: 1,
                child: Icon(
                  FontAwesomeIcons.carAlt,
                  color: Colors.white,
                  size: 36.0,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  "Showroom",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                  maxLines: 1,
                  maxFontSize: 18.0,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Container buildButtonLandscape() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.3,
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
              Expanded(
                flex: 2,
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  "Build",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                  maxLines: 1,
                  maxFontSize: 18.0,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Container myGarageButtonLandscape() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.3,
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
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  "My Garage",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                  maxLines: 1,
                  maxFontSize: 18.0,
                ),
              ),
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
                        child: urlImage == ""
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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (Route<dynamic> route) => false);

          signOutProcess();
        },
      );

  ListTile findMenu() => ListTile(
        leading: Icon(Icons.search, color: Colors.white),
        title: Text("Find", style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchGarageScreen();
          }));
        },
      );

  ListTile showroomMenu() => ListTile(
        leading: Icon(Icons.home, color: Colors.white),
        title: Text("My Garage", style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyGarageScreen();
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
