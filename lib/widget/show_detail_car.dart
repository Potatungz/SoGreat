import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';
import 'package:flutter_sogreat_application/model/image_gallery_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/utility/sqlite_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailCar extends StatefulWidget {
  final UserModel userModel;
  final CarModel carModel;
  final ImageGalleryModel imageGalleryModel;
  final MyGarageModel myGarageModel;
  ShowDetailCar(
      {Key key,
      this.userModel,
      this.carModel,
      this.imageGalleryModel,
      this.myGarageModel})
      : super(key: key);

  @override
  _ShowDetailCarState createState() => _ShowDetailCarState();
}

class _ShowDetailCarState extends State<ShowDetailCar> {
  UserModel userModel;
  CarModel carModel;
  ImageGalleryModel imageGalleryModel;
  MyGarageModel myGarageModel;

  String idShowroom, brandName, brandImage, modelName, pathImage, detail;
  String idCar, idGarage, modelCar;
  List<CarModel> carModels = List();
  List<ImageGalleryModel> imageGalleryModels = List();
  List<GarageModel> garageModels = List();
  List<MyGarageModel> mygarageModels = List();

  @override
  void initState() {
    super.initState();
    print("Enter Show Detail Page");
    userModel = widget.userModel;
    carModel = widget.carModel;
    imageGalleryModel = widget.imageGalleryModel;
    readImageGallery();
  }

  Future<Null> readImageGallery() async {
    idCar = carModel.id;
    String url =
        "${MyConstant().domain}/SoGreat/getImageWhereIdCar.php?isAdd=true&idCar=$idCar";
    Response response = await Dio().get(url);
    print("res ------> $response");

    var result = json.decode(response.data);
    print("result = $result");

    for (var map in result) {
      ImageGalleryModel imageGalleryModel = ImageGalleryModel.fromJson(map);
      setState(() {
        imageGalleryModels.add(imageGalleryModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
          height: 340.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg_showroom.png"),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 340,
          color: Colors.transparent,
          child: Container(
              margin: EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${MyConstant().domain}${carModel.pathImage}"),
                    fit: BoxFit.cover),
              )),
        ),
        Column(
          children: [
            Row(
              children: [
                Opacity(
                  opacity: 0.9,
                  child: ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.centerLeft,
                            colors: [Colors.black, Colors.transparent])
                        .createShader(rect),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 60.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 60.0,
                  color: Color(0xfff1f1f1),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          // image: AssetImage("images/logo.png"),
                          image: NetworkImage(
                              "${MyConstant().domain}${carModel.brandImage}")),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 280.0),
            buildCarDetail(),
            imageGallery(),
            SizedBox(height: 20.0),
            buildAddButton(context),
            SizedBox(height: 20.0),
          ],
        ),
        buildTitle(context),
      ]),
    );
  }

  Container buildAddButton(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyStyle().primaryColor),
      child: FlatButton(
        onPressed: () {
          addCarToGarage();
        },
        child: Text(
          "ADD TO GARAGE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Text(
          "${carModel.modelName}",
          // "Test",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
          textAlign: TextAlign.end,
        ),
      )
    ]);
  }

  Widget buildCarDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            color: Color(0xfff1f1f1),
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 8, right: 8),
            height: 110,
            child: Column(
              children: [
                Text(
                  "Acceleration",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "3.6 Sec",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          width: 1,
          color: Color(0xffe0e0e0),
        ),
        Expanded(
          child: Container(
            color: Color(0xffff1f1),
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 8, right: 8),
            height: 110,
            child: Column(
              children: [
                Text(
                  "Horsepower",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "550 HP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          width: 1,
          color: Color(0xffe0e0e0),
        ),
        Expanded(
          child: Container(
            color: Color(0xfff1f1f1),
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 8, right: 8),
            height: 110,
            child: Column(
              children: [
                Text(
                  "Torque",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "502 ib-ft",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget imageGallery() {
    return Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.transparent,
        height: 220.0,
        child: ListView.builder(
          itemCount: imageGalleryModels.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.all(10.0),
            width: 324.0,
            height: 170.0,
            //color: Colors.red,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${MyConstant().domain}${imageGalleryModels[index].pathImage}"),
                    fit: BoxFit.cover)),
          ),
          scrollDirection: Axis.horizontal,
        ));
  }

  Future<Null> addCarToGarage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idGarage = preferences.getString('id');
    idCar = carModel.id;
    modelCar = carModel.modelName;
    pathImage = carModel.pathImage;
    brandImage = carModel.brandImage;
    print("idGarage = $idGarage , idCar = $idCar, ModelCar = $modelCar");

    String urlAddCar =
        "${MyConstant().domain}/SoGreat/addCarToMyGarage.php?isAdd=true&idGarage=$idGarage&idCar=$idCar&ModelCar=$modelCar&PathImage=$pathImage&BrandImage=$brandImage";
    try {
      Response response = await Dio().get(urlAddCar);
      print("res = $response");

      if (response.toString() == "true") {
        Navigator.pop(context);
      } else {
        normailDialog(context, "Can't to Create Garage. Try Again");
      }
    } catch (e) {}
    
    // Map<String, dynamic> map = Map();
    // map['idGarage'] = idGarage;
    // map['idCar'] = idCar;
    // map['modelCar'] = modelCar;
    // map['pathImage'] = pathImage;
    // map['brandImage'] = brandImage;
    // print("map ==> ${map.toString()}");
    // MyGarageModel myGarageModel = MyGarageModel.fromJson(map);
    // var object = await SQLiteHelper().readAllDataFromSQLite();
    // print("object = ${object.toString()}");
    // if (object.length == 0) {
    //   await SQLiteHelper().insertDataToSQLite(myGarageModel).then((value) {
    //     print("Insert Success");
    //   });
    // } else {
    //   String idGarageSQLite = object[0].idGarage;
    //   print("idGarageSQLite ===> $idGarageSQLite");

    //   if (idGarage == idGarageSQLite) {
    //     await SQLiteHelper().insertDataToSQLite(myGarageModel).then((value) {
    //       print("Insert Success");
    //     });
    //   } else {
    //     normailDialog(context, "string");
    //   }
    // }
  }
}
