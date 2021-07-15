import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  final UserModel userModel;
  ChangePasswordScreen({Key key, this.userModel}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String id, password, currentPassword, newPassword, confirmNewPassword;
  UserModel userModel;

  bool statusRedEyeCurrentPassword = true;
  bool statusRedEyeNewPassword = true;
  bool statusRedEyeConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    readCurrentPassword();
  }

  Future<Null> readCurrentPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    password = preferences.getString("Password");
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
        password = userModel.password;
      });
    }

    print("Password = $password");
  }

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
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        physics: ScrollPhysics(),
                        children: [
                          Text(
                            'Current Password',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                                  currentPassword = value.trim(),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Current Password';
                                }
                                if (password != currentPassword) {
                                  return "Current Password does not match";
                                }
                                return null;
                              },
                              obscureText: statusRedEyeCurrentPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: MyStyle().primaryColor)),
                                prefix: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                ),
                                hintText: "Current Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        statusRedEyeCurrentPassword =
                                            !statusRedEyeCurrentPassword;
                                      },
                                    );
                                  },
                                  icon: statusRedEyeCurrentPassword
                                      ? Icon(Icons.remove_red_eye,
                                          color: Colors.black45)
                                      : Icon(Icons.remove_red_eye_outlined,
                                          color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'New Password',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onChanged: (value) => newPassword = value.trim(),
                              validator: (String value) {
                                if (newPassword.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                if (newPassword.length < 8) {
                                  return 'Password must be atleast 8 characters long';
                                }
                                if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return 'Password should contain letters, numbers & symbols';
                                }
                                if(currentPassword == newPassword){
                                  return "New password does match current password";
                                }
                                return null;
                              },
                              obscureText: statusRedEyeNewPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: MyStyle().primaryColor)),
                                prefix: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                ),
                                hintText: "New Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        statusRedEyeNewPassword =
                                            !statusRedEyeNewPassword;
                                      },
                                    );
                                  },
                                  icon: statusRedEyeNewPassword
                                      ? Icon(Icons.remove_red_eye,
                                          color: Colors.black45)
                                      : Icon(Icons.remove_red_eye_outlined,
                                          color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 6.0, right: 8.0),
                              child: Text(
                                "Use 8 or more characters with a mix of letters, numbers & symbols",
                                style: TextStyle(
                                    fontSize: 11.0, color: Colors.grey),
                              )),
                          SizedBox(height: 10),
                          Text(
                            'Re-enter Password',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                                  confirmNewPassword = value.trim(),
                              validator: (String value) {
                                if (confirmNewPassword.isEmpty) {
                                  return 'Please re-enter password';
                                }
                                if (confirmNewPassword.length < 8) {
                                  return 'Password must be atleast 8 characters long';
                                }
                                if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return 'Password should contain letters, numbers & symbols';
                                }
                                if(currentPassword == confirmNewPassword){
                                  return "Confirm password does match current password";
                                }
                                if (newPassword != confirmNewPassword) {
                                  return "Password does not match";
                                }
                                return null;
                              },
                              obscureText: statusRedEyeConfirmPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: MyStyle().primaryColor)),
                                prefix: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                ),
                                hintText: "Re-enter Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        statusRedEyeConfirmPassword =
                                            !statusRedEyeConfirmPassword;
                                      },
                                    );
                                  },
                                  icon: statusRedEyeConfirmPassword
                                      ? Icon(Icons.remove_red_eye,
                                          color: Colors.black45)
                                      : Icon(Icons.remove_red_eye_outlined,
                                          color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: MyStyle().primaryColor),
                            child: FlatButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    print(
                                        "Old Password = $currentPassword , New Password = $newPassword , ConfirmPassword = $confirmNewPassword");
                                    editPassword();
                                  }
                                  // print(
                                  //     "Old Password = $currentPassword , New Password = $newPassword , ConfirmPassword = $confirmNewPassword");
                                  // if ((currentPassword?.isEmpty ?? true) ||
                                  //     (newPassword?.isEmpty ?? true) ||
                                  //     (confirmNewPassword?.isEmpty ?? true)) {
                                  //   print("Have Space");
                                  //   normailDialog(
                                  //       context, "Have Space ? Please Fill");
                                  // } else if (currentPassword != password) {
                                  //   normailDialog(
                                  //       context, "Current password incorrect");
                                  // } else if ((currentPassword == newPassword) ||
                                  //     (currentPassword == confirmNewPassword)) {
                                  //   normailDialog(context,
                                  //       "New password you have same old password");
                                  // } else if (newPassword != confirmNewPassword) {
                                  //   normailDialog(context,
                                  //       "Confirm Password does match new password");
                                  // } else {
                                  //   print("No Space");
                                  //   editPassword();
                                  // }
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<Null> editPassword() async {
    password = newPassword;
    var encodePassword = Uri.encodeComponent(password);
    String url =
        "${MyConstant().domain}/SoGreat/editPasswordWhereId.php?isAdd=true&id=$id&Password=$encodePassword";
    print("URL = $url");
    
    Response response = await Dio().get(url);

    if (response.toString() == "true") {
      Navigator.pop(context);
    } else {
      normailDialog(context, "Change Password Fail");
    }
  }
}
