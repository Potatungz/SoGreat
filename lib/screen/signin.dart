import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/home.dart';
import 'package:flutter_sogreat_application/screen/signup.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  void initState(){
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance()async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String user = preferences.getString("User");
      if (user != null && user.isNotEmpty) {
        if (user == "$user") { 
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home(),);
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        } else {
          normailDialog(context, "Error Username");
        }
      }
      
    } catch (e) {
    }

  }

  bool statusRedEye = true;
  String user, password;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black, Colors.transparent]).createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("images/loginscreenfull.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ))),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Image.asset("images/logo.png"),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        onChanged: (value) => user = value.trim(),
                        style: MyStyle().mainBody1,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(FontAwesomeIcons.user,
                              size: 20.0, color: Colors.white),
                          hintText: "Username",
                          hintStyle: MyStyle().mainBody1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        onChanged: (value) => password = value.trim(),
                        obscureText: statusRedEye,
                        style: MyStyle().mainBody1,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            hintText: "Password",
                            hintStyle: MyStyle().mainBody1,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  statusRedEye = !statusRedEye;
                                });
                              },
                              icon: statusRedEye
                                  ? Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                    )
                                  : Icon(Icons.remove_red_eye_outlined,
                                      color: Colors.white),
                            )),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyStyle().primaryColor),
                      child: FlatButton(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16.0),
                        ),
                        onPressed: () {
                          if ((user?.isEmpty ?? true) ||
                              (password?.isEmpty ?? true)) {
                            normailDialog(context, "Please Insert Data");
                          } else {
                            checkAuthen();
                          }
                          // MaterialPageRoute route =
                          //     MaterialPageRoute(builder: (value) => Home());
                          // Navigator.push(context, route);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp();
                          }));
                        },
                        child: Text(
                          "Create New Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            )),
      ],
    );
  }

  Future<Null> checkAuthen() async {
    String url =
        "${MyConstant().domain}/SoGreat/getUserWhereUser.php?isAdd=true&User=$user";
    try {
      Response response = await Dio().get(url);
      print("res = $response");

      var result = json.decode(response.data);
      print("result = $result");

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        
        if (password == userModel.password) {
          routeToService(Home(), userModel);
        } else {
          normailDialog(context, "Wrong!! Password. Try again.");
        }
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", userModel.id);
    preferences.setString("Name", userModel.name);
    preferences.setString("User", userModel.user);
    preferences.setString("Gender", userModel.gender);
    preferences.setString("Country", userModel.country);
    preferences.setString("URLImage", userModel.urlImage);
    preferences.setString("NameGarage", userModel.nameGarage);

    print("Enter Route to Service");

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
