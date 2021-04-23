import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';
import 'package:flutter_sogreat_application/model/image_gallery_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/showroom_screen.dart';
import 'package:flutter_sogreat_application/utility/dialog.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/utility/sqlite_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailMyCar extends StatefulWidget {
  final UserModel userModel;
  final MyGarageModel myGarageModel;
  final CarModel carModel;
  ShowDetailMyCar({Key key, this.userModel, this.myGarageModel, this.carModel})
      : super(key: key);

  @override
  _ShowDetailMyCarState createState() => _ShowDetailMyCarState();
}

class _ShowDetailMyCarState extends State<ShowDetailMyCar> {
  UserModel userModel;
  CarModel carModel;
  MyGarageModel myGarageModel;

  String brandImage, modelName, pathImage;
  String idCar, idGarage, modelCar;
  List<CarModel> carModels = List();
  List<MyGarageModel> mygarageModels = List();

  @override
  void initState() {
    super.initState();
    print("Enter Show Detail Page");
    userModel = widget.userModel;
    myGarageModel = widget.myGarageModel;
    carModel = widget.carModel;
    readMyCar();
  }

  Future<Null> readMyCar() async {
    print("Enter readMyCar");
    idGarage = myGarageModel.idGarage;
    print("My iD Car = $idGarage");

    String url =
        "${MyConstant().domain}/SoGreat/getCarWhereIdGarage.php?isAdd=true&idGarage=$idGarage";

    Response response = await Dio().get(url);
    print("res ------> $response");

    var result = json.decode(response.data);
    print("result = $result");

    for (var map in result) {
      MyGarageModel myGarageModel = MyGarageModel.fromJson(map);
      setState(() {
        mygarageModels.add(myGarageModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return mygarageModels.length == 0
        ? MyStyle().showProgress()
        : SingleChildScrollView(
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
                              "${MyConstant().domain}${myGarageModel.pathImage}"),
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
                                // image: AssetImage("images/logo.png")),
                                image: NetworkImage(
                                    "${MyConstant().domain}${myGarageModel.brandImage}")),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 280.0),
                  buildCarDetail(),
                  myCarInGarage(),
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
          "ADD Car",
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
          "${myGarageModel.modelCar}",
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

  Widget myCarInGarage() {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.transparent,
      height: 220.0,
      child: ListView.builder(
        itemCount: mygarageModels.length,
        itemBuilder: (context, index) => Stack(children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                width: 324.0,
                height: 150.0,
                // color: Colors.red,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${MyConstant().domain}${mygarageModels[index].pathImage}"),
                        fit: BoxFit.cover)),
              ),
              Text(
                "${mygarageModels[index].modelCar}",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.grey,
                  onPressed: () async {
                    print("$index");
                    print("Click Delete Car ID ${mygarageModels[index].id}");
                    deleteCarFromGarage(mygarageModels[index],index);
                  })),
        ]),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Future<Null> addCarToGarage() async {
    print("Touch Add Car Button");
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowRoomScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<Null> deleteCarFromGarage(MyGarageModel myGarageModel, int index) async {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Move to Your Garage?"),
              content: new Text("Car in your garage will be delete now?"),
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
                      String id = myGarageModel.id;
                      print("Delete Car id = $id");
                      String urlDeleteCar =
                          "${MyConstant().domain}/SoGreat/deleteCarWhereIdGarage.php?isAdd=true&id=$id";
                      try {
                        Response response = await Dio().get(urlDeleteCar);
                        print("res = $response");

                        if (response.toString() == "true") {
                          setState(() {
                            mygarageModels.removeAt(index);
                          });
                          print("Delete Success");
                          Navigator.of(context).pop();
                        } else {
                          normailDialog(context, "Can't Delete Car. Try Again");
                        }
                      } catch (e) {}
                    },
                    child: Text("Move"))
              ],
            ));
  }
}
