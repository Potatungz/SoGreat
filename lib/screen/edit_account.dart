import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/change_password_screen.dart';
import 'package:flutter_sogreat_application/screen/home.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccount extends StatefulWidget {
  final UserModel userModel;
  EditAccount({Key key, this.userModel}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  UserModel userModel;
  String id;
  String nameUser = "-";
  String phone = "-";
  String urlImage;
  String nameGarage;
  File file;

  String gender = "Choose Gender";
  String country = "Choose Country";

  bool editImage = false;

  List<String> listGender = <String>[
    "Choose Gender",
    "Male",
    "Female",
  ];


  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    readCurrentInfo();
  }

  Future<Null> readCurrentInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    nameUser = preferences.getString("Name");
    urlImage = preferences.getString("URLImage");
    phone = preferences.getString("Phone");
    id = preferences.getString("id");
    gender = preferences.getString("Gender");
    country = preferences.getString("Country");
    nameGarage = preferences.getString("NameGarage");

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
        gender = userModel.gender;
        country = userModel.country;
        nameGarage = userModel.nameGarage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('en', 'US')],
      localizationsDelegates: [CountryLocalizations.delegate],
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            "Edit an account",
            style: TextStyle(color: Colors.black),
          ),
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
                // Center(
                //   child: Text(
                //     "Edit an account",
                //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                //   ),
                // ),
                // SizedBox(height: 15),
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
                              ? Image.network(
                                  "${MyConstant().domain}$urlImage",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                TextButton(
                  child: Text("Change Profile Photo"),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()));
                  },
                ),
                Divider(
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(height: 20),
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
                          onChanged: (value) => nameUser = value.trim(),
                          //autofocus: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  FontAwesomeIcons.userAlt,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "$nameUser",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 18.0)),
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
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => phone = value.trim(),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: phone == "null" ? "Phone" : "$phone",
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 18.0)),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(right: 8.0, left: 8.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Icon(
                                FontAwesomeIcons.genderless,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            DropdownButton<String>(
                              underline: SizedBox(),
                              value: gender,
                              icon: Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              iconSize: 0.0,
                              elevation: 10,
                              style: TextStyle(color: Colors.grey),
                              onChanged: (String newValue) {
                                setState(() {
                                  gender = newValue;
                                });
                              },
                              items: listGender.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(right: 8.0, left: 8.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: CountryCodePicker(
                                initialSelection: '$country',
                                textStyle: TextStyle(fontSize: 17.0),
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: true,
                                showFlag: true,
                                alignLeft: true,
                                favorite: ['TH', 'US', 'EN'],
                                onChanged: (c) {
                                  setState(() {
                                    country = c.name;
                                  });
                                },
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade300),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChangePasswordScreen();
                            })).then((value) => readCurrentInfo());
                          },
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                color: Colors.black26,
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
                          color: MyStyle().primaryColor),
                      child: FlatButton(
                          onPressed: () => confirmDialog(),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          )),
                    ),
                  ],
                )
              ]),
            )),
      ),
    );
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
        editImage = true;
        Navigator.pop(context);
      });
    } catch (e) {}
  }

  Future<Null> confirmDialog() async {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text("Edit Account"),
        content: new Text("Your account will be edit now?"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          FlatButton(
              onPressed: () async {
                print("Edit Data");
                Navigator.pop(context);
                editThread();
              },
              child: Text("OK"))
        ],
      ),
    );
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

  Future<Null> editThread() async {
    print("editThred");
    print("editImage => $editImage");
    if (editImage) {
      Random random = Random();
      int i = random.nextInt(100000);
      String nameFile = "editProfile$i.jpg";

      Map<String, dynamic> map = Map();
      map["file"] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      String urlUpload = "${MyConstant().domain}/SoGreat/saveProfile.php";
      await Dio().post(urlUpload, data: formData).then((value) async {
        urlImage = "/SoGreat/Profile/$nameFile";

        String id = userModel.id;
        print("gender $gender");
        print("gender $country");
        String url =
            "${MyConstant().domain}/SoGreat/editUserWhereId.php?isAdd=true&id=$id&Name=$nameUser&Phone=$phone&URLImage=$urlImage&Gender=$gender&Country=$country&NameGarage=$nameGarage";
        print("See URL = $url");
        Response response = await Dio().get(url);
        if (response.toString() == "true") {
          Navigator.pop(context);
        } else {
          print("Updagte Fail");
          normailDialog(context, "Update Fail");
        }
      });
    } else {
      String id = userModel.id;
      urlImage = userModel.urlImage;
      print("gender $gender");
      print("country $country");
      String url =
          "${MyConstant().domain}/SoGreat/editUserWhereId.php?isAdd=true&id=$id&Name=$nameUser&Phone=$phone&URLImage=$urlImage&Gender=$gender&Country=$country&NameGarage=$nameGarage";
      Response response = await Dio().get(url);
      if (response.toString() == "true") {
        Navigator.pop(context);
      } else {
        print("Updagte Fail");
        normailDialog(context, "Update Fail");
      }
    }
  }
}
