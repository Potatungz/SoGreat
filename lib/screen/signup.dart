import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/utility/show_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  String name, user, password, confirmpassword, urlImage;

  String phone = "Your Phone Number";
  String gender = "Choose Gender";
  String country = "Choose Country";
  String nameGarage = "";
  String carAmount = "0";

  bool statusRedEyeNewPassword = true;
  bool statusRedEyeConfirmPassword = true;
  bool isButtonDisabled = true;

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
                                  "images/avatar.png",
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
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()));
                              // chooseImage(ImageSource.gallery);
                            },
                          )
                          // child: Icon(Icons.edit, color: Colors.grey),
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Center(
                          child: TextFormField(
                        keyboardType: TextInputType.name,
                        validator:
                            RequiredValidator(errorText: "Please a Enter Name"),
                        onChanged: (value) => name = value.trim(),
                        //autofocus: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.user,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Full name",
                            hintText: "Enter Your Full Name",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400)),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Center(
                          child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                        onChanged: (value) => user = value.trim(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0),
                              child: Icon(
                                FontAwesomeIcons.envelope,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Email",
                            hintText: "Enter Your email",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400)),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: statusRedEyeNewPassword,
                          onChanged: (value) => password = value.trim(),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            if (value.length < 8) {
                              return 'Password must be atleast 8 characters long';
                            }
                            // return null;

                            // if (!RegExp(
                            //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~^]).{8,}$')
                            //     .hasMatch(value)) {
                            //   return 'Password should contain letters, numbers & symbols';
                            // }
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~@#$%^&*+=`|{}:;!.,?_\\\"()\[\]\/-\<\>]).{8,}$')
                                .hasMatch(value)) {
                              return 'Password should contain letters, numbers & symbols';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
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
                            labelText: "Password",
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, right: 8.0),
                        child: Text(
                          "Use 8 or more characters with a mix of letters, numbers & symbols",
                          style: TextStyle(fontSize: 11.0, color: Colors.grey),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Center(
                          child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: statusRedEyeConfirmPassword,
                        onChanged: (value) => confirmpassword = value.trim(),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please re-enter password';
                          }
                          if (value.length < 8) {
                            return 'Password must be atleast 8 characters long';
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~@#$%^&*+=`|{}:;!.,?_\\\"()\[\]\/-\<\>]).{8,}$')
                              .hasMatch(value)) {
                            return 'Password should contain letters, numbers & symbols';
                          }
                          if (password != confirmpassword) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        //autofocus: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
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
                            labelText: "Re-enter Password",
                            hintText: "Re-enter Password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400)),
                      )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyStyle().primaryColor),
                      child: FlatButton(
                          onPressed: isButtonDisabled == false
                              ? null
                              : () async {
                                  print("isButtonDisabled = $isButtonDisabled");
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      isButtonDisabled = false;
                                    });

                                    if (file == null) {
                                      final byteData = await rootBundle
                                          .load('images/avatar.png');
                                      print(byteData);

                                      file = File(
                                          '${(await getApplicationDocumentsDirectory()).path}/$byteData');
                                      print("2222");

                                      await file.writeAsBytes(
                                          byteData.buffer.asUint8List());
                                      print("333");
                                      setState(() {
                                        file = File(file.path);
                                      });
                                      print("file = ${file.path}");
                                    }
                                    checkUser();
                                  }
                                },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          )),
                    ),
                  ],
                ),
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
        setState(() {
          isButtonDisabled = true;
        });

        normailDialog(context, "$user Already has a duplicate user");
      }
    } catch (e) {}
  }

  Future<Null> registerThred() async {
    // var encodePassword = Uri.encodeComponent(password);
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodePassword = stringToBase64.encode(password);
    print("Encode = $encodePassword");
    String url =
        "${MyConstant().domain}/SoGreat/addUser.php?isAdd=true&Name=$name&User=$user&Password=$encodePassword&Phone=$phone&Country=$country&Gender=$gender&URLImage=$urlImage&NameGarage=$nameGarage&CarAmount=$carAmount";

    print("URL: $url");
    try {
      Response response = await Dio().post(url);
      print("res = $response");
      showToast(context, "Create an Account Successful",
          duration: 4, gravity: Toast.BOTTOM);

      if (response.toString() == "true") {
        Navigator.pop(context);
      } else {
        showToast(context, "Can't to Register. Try Again",
            duration: 4, gravity: Toast.BOTTOM);
      }
    } catch (e) {}
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 600.0,
        maxWidth: 600.0,
      );
      setState(() {
        file = File(object.path);
        Navigator.pop(context);
      });
    } catch (e) {}
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  chooseImage(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  chooseImage(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }
}
