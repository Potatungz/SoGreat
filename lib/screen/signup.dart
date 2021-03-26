import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name, user, password, confirmpassword, urlImage, phone, gender, country;
  File file;

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
      body: Container(
          padding: EdgeInsets.only(
            left: 8,
            top: 20,
            right: 8,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(children: [
              Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 146.0,
                      height: 146.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                          child: file == null
                              ? Image.asset(
                                  "images/avatar_blank.png",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              color: Colors.white),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              chooseImage(ImageSource.gallery);
                            },
                          )
                          // child: Icon(Icons.edit, color: Colors.grey),
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: TextField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) => name = value.trim(),
                        //autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.user,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.grey)),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => user = value.trim(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.envelope,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Enter Your Email",
                            hintStyle: TextStyle(color: Colors.grey)),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: TextField(
                        obscureText: true,
                        onChanged: (value) => password = value.trim(),
                        //autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Create Your Password",
                            hintStyle: TextStyle(color: Colors.grey)),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: TextField(
                        obscureText: true,
                        onChanged: (value) => confirmpassword = value.trim(),
                        //autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Re-enter Password",
                            hintStyle: TextStyle(color: Colors.grey)),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyStyle().primaryColor),
                    child: FlatButton(
                        onPressed: () {
                          print(
                              "name = $name, user = $user, password = $password, re-password = $confirmpassword");
                          if ((name?.isEmpty ?? true) ||
                              (user?.isEmpty ?? true) ||
                              (password?.isEmpty ?? true) ||
                              (confirmpassword?.isEmpty ?? true)) {
                            print("Have Space");
                            normailDialog(context, "Have Space ? Please Fill");
                          } else if (file == null) {
                            normailDialog(context, "Please upload Image");
                          } else if (password != confirmpassword) {
                            normailDialog(context, "Password does macth");
                          } else {
                            print("No Space");
                            // checkUser();
                            checkUser();
                          }
                          //Navigator.pop(context);
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              color: MyStyle().dardkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                ],
              )
            ]),
          )),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = "profile$i.jpg";
    print("NameImage = $nameImage, pathImage = ${file.path}");

    String url = "${MyConstant().domain}/SoGreat/saveProfile.php";
    try {
      Map<String, dynamic> map = Map();
      map["file"] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print("Response ===> $value");
        urlImage = "/SoGreat/Profile/$nameImage";
        print("urlImage = $urlImage");
        registerThred();
      });
    } catch (e) {}
  }

  Future<Null> checkUser() async {
    String url =
        "${MyConstant().domain}/SoGreat/getUserWhereUser.php?isAdd=true&User=$user";

    try {
      Response response = await Dio().get(url);
      if (response.toString() == "null") {
        uploadImage();
      } else {
        normailDialog(context, "$user Already has a duplicate user");
      }
    } catch (e) {}
  }

  Future<Null> registerThred() async {
  
        String url = "${MyConstant().domain}/SoGreat/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&Phone=$phone&Gender=$gender&Country=$country&URLImage=$urlImage";

    try {
      Response response = await Dio().get(url);
      print("res = $response");

      if (response.toString() == "true") {
        Navigator.pop(context);
      } else {
        normailDialog(context, "Can't to Register. Try Again");
      }
    } catch (e) {}
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }
}
