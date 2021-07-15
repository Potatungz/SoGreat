import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/home.dart';
import 'package:flutter_sogreat_application/screen/signup.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_encryption.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/utility/show_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  String recoverEmail;
  String newPassWord;

  var decryptedPassword;

  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String user = preferences.getString("User");
      if (user != null && user.isNotEmpty) {
        if (user == "$user") {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Home(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        } else {
          normailDialog(context, "Error Username");
        }
      }
    } catch (e) {}
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
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset("images/logo.png"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        onChanged: (value) => user = value.trim(),
                        style: MyStyle().mainBody1,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                              size: 20.0, color: Colors.white),
                          hintText: "example@domain.com",
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      height: 60.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.grey[500].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
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
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.white70),
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
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: TextButton(
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  titlePadding: EdgeInsets.only(
                                    left: 20.0,
                                    top: 30.0,
                                    right: 20.0,
                                  ),
                                  title: Text(
                                    "We will send your password to this email account.",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0,
                                      top: 20.0,
                                      right: 20.0,
                                      bottom: 20.0),
                                  children: [
                                    Form(
                                      key: formKey,
                                      child: Center(
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Please a Enter';
                                            }
                                            if (!RegExp(
                                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                .hasMatch(value)) {
                                              return 'Please a valid Email';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) =>
                                              recoverEmail = value.trim(),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                      color: MyStyle()
                                                          .primaryColor)),
                                              labelText: "Email",
                                              hintText: "Enter Your Email",
                                              prefixIcon: Icon(Icons.email)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: MyStyle().primaryColor),
                                      child: FlatButton(
                                        onPressed: () {
                                          print(
                                              "isButtonDisable = $isButtonDisabled");
                                          if (isButtonDisabled) {
                                            if (formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                isButtonDisabled = false;
                                              });
                                              print(
                                                  "isButtonDisable = $isButtonDisabled");
                                              checkEmail();
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "Back",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignUp();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(color: MyStyle().primaryColor),
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              )),
            )),
      ],
    );
  }

  Future resetPassword() async {
    user = recoverEmail;
    print("recovery email = $user");
    String url =
        "${MyConstant().domain}/SoGreat/resetPassword.php?isAdd=true&User=$user";
    print("url = $url");

    try {
      showToast(context, "Send new password to email : $user",
          duration: 4, gravity: Toast.BOTTOM);
      Response response = await Dio().get(url);
      print("res ===> ${response.statusCode}");

      if (response.statusCode == 200) {
        setState(() {
          isButtonDisabled = true;
        });
        Navigator.of(context).pop();
      } else {
        print("Reset Password Fail");
        setState(() {
          isButtonDisabled = true;
        });
        
        showToast(context, "Reset Password failed",
            duration: 4, gravity: Toast.BOTTOM);
      }
    } catch (e) {}
  }

  Future<Null> checkEmail() async {
    user = recoverEmail;
    String url =
        "${MyConstant().domain}/SoGreat/getUserWhereUser.php?isAdd=true&User=$user";
    try {
      Response response = await Dio().get(url);
      print("res = $response");

      var result = json.decode(response.data);
      print("result = $result");
      if (result == null) {
        setState(() {
          isButtonDisabled = true;
        });
        showToast(context, "Invalid this email address",
            duration: 4, gravity: Toast.BOTTOM);
      } else {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);

          if (recoverEmail == userModel.user) {
            resetPassword();
          } else {
            setState(() {
              isButtonDisabled = true;
            });
            showToast(context, "Invalid this email address",
                duration: 4, gravity: Toast.BOTTOM);
          }
        }
      }
    } catch (e) {}
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

  Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", userModel.id);
    preferences.setString("Name", userModel.name);
    preferences.setString("User", userModel.user);
    preferences.setString("Gender", userModel.gender);
    preferences.setString("Country", userModel.country);
    preferences.setString("URLImage", userModel.urlImage);
    preferences.setString("NameGarage", userModel.nameGarage);
    preferences.setString("CarAmount", userModel.carAmount);

    print("Enter Route to Service");

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
