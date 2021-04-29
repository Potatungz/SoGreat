import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
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
  String id, nameUser, phone, urlImage;
  File file;

  String countryChoose;
  String genderChoose = "Gender";

  List<String> listGender = <String>[
    "Gender",
    "Male",
    "Female",
  ];

  List<String> listCounrtry = <String>[
    "Country",
    "Thailand",
    "Combodia",
    "Malaysia",
    "Singpore",
    "England",
    "Germany",
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
    genderChoose = preferences.getString("Gender");
    countryChoose = preferences.getString("Country");

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
        genderChoose = userModel.gender;
        countryChoose = userModel.country;
      });
    }
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
                  "Edit an account",
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
                            ? Image.network(
                                "${MyConstant().domain}$urlImage",
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                      ),
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
                              Icons.edit,
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
                                FontAwesomeIcons.user,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "$nameUser",
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
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => phone = value.trim(),
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
                            hintText: phone == "null" ? "Phone" : "$phone",
                            hintStyle: TextStyle(color: Colors.grey)),
                      )),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  //       Container(
                  //         padding: EdgeInsets.only(right: 8.0, left: 8.0),
                  //         width: MediaQuery.of(context).size.width * 0.4,
                  //         height: 50,
                  //         decoration: BoxDecoration(
                  //             border:
                  //                 Border.all(color: Colors.grey, width: 1.0),
                  //             color: Colors.white.withOpacity(0.5),
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Center(
                  //           child: DropdownButtonHideUnderline(
                  //             child: ButtonTheme(
                  //               alignedDropdown: true,
                  //               child: DropdownButton(
                  //                 iconSize: 36.0,
                  //                 icon: Icon(Icons.arrow_drop_down),
                  //                 isExpanded: false,
                  //                 elevation: 0,
                  //                 hint: genderChoose == "null" ||
                  //                         genderChoose.isEmpty
                  //                     ? Text(
                  //                         "Gender",
                  //                         style: TextStyle(color: Colors.grey),
                  //                       )
                  //                     : Text(
                  //                         "$genderChoose",
                  //                         style: TextStyle(color: Colors.grey),
                  //                       ),
                  //                 value: genderChoose,
                  //                 items: listGender.map((valueItem) {
                  //                   return DropdownMenuItem(
                  //                     value: valueItem,
                  //                     child: Text(
                  //                       valueItem,
                  //                       style: TextStyle(color: Colors.grey),
                  //                     ),
                  //                   );
                  //                 }).toList(),
                  //                 onChanged: (newValue) {
                  //                   setState(
                  //                     () {
                  //                       genderChoose = newValue;
                  //                     },
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.only(right: 8.0, left: 8.0),
                  //         width: MediaQuery.of(context).size.width * 0.4,
                  //         height: 50,
                  //         decoration: BoxDecoration(
                  //             border:
                  //                 Border.all(color: Colors.grey, width: 1.0),
                  //             color: Colors.white.withOpacity(0.5),
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Center(
                  //           child: DropdownButtonHideUnderline(
                  //             child: ButtonTheme(
                  //               alignedDropdown: false,
                  //               child: DropdownButton(
                  //                   iconSize: 36.0,
                  //                   icon: Icon(Icons.arrow_drop_down),
                  //                   isExpanded: true,
                  //                   elevation: 0,
                  //                   hint: countryChoose == "null" ||
                  //                           countryChoose.isEmpty
                  //                       ? Text(
                  //                           "Country",
                  //                           style:
                  //                               TextStyle(color: Colors.grey),
                  //                         )
                  //                       : Text(
                  //                           "$countryChoose",
                  //                           style:
                  //                               TextStyle(color: Colors.grey),
                  //                         ),
                  //                   value: countryChoose,
                  //                   items: listCounrtry.map((valueItem) {
                  //                     return DropdownMenuItem(
                  //                       value: valueItem,
                  //                       child: Text(
                  //                         valueItem,
                  //                         style: TextStyle(color: Colors.grey),
                  //                       ),
                  //                     );
                  //                   }).toList(),
                  //                   onChanged: (newValue) {
                  //                     setState(() {
                  //                       countryChoose = newValue;
                  //                     });
                  //                   }),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                        onPressed: () => confirmDialog(),
                        child: Text(
                          "Save",
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

  Future<Null> confirmDialog() async {
    showDialog(
        context: context,
        builder: (context) =>
            SimpleDialog(title: Text("Edit account ?"), children: <Widget>[
              OutlineButton(
                onPressed: () {
                  print("Edit Data");
                  Navigator.pop(context);
                  editThread();
                },
                child: Text("Sure?"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("ไม่แน่ใจ"),
              ),
            ]));
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

      String url =
          "${MyConstant().domain}/SoGreat/editUserWhereId.php?isAdd=true&id=$id&Name=$nameUser&Phone=$phone&URLImage=$urlImage&Gender=$genderChoose&Country=$countryChoose";

      Response response = await Dio().get(url);
      if (response.toString() == "true") {
        Navigator.pop(context);
      } else {
        print("Updagte Fail");
        normailDialog(context, "Update Fail");
      }
    });
  }
}
