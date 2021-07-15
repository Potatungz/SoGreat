import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';

class ShowDetailOtherCar extends StatefulWidget {
  final UserModel userModel;
  final MyGarageModel myGarageModel;
  final CarModel carModel;
  ShowDetailOtherCar(
      {Key key, this.userModel, this.myGarageModel, this.carModel})
      : super(key: key);
  @override
  _ShowDetailOtherCarState createState() => _ShowDetailOtherCarState();
}

class _ShowDetailOtherCarState extends State<ShowDetailOtherCar> {
  UserModel userModel;
  CarModel carModel;
  MyGarageModel myGarageModel;

  String brandImage;
  String pathImage;
  String modelCar;
  String idCar, idGarage;
  List<CarModel> carModels = List();
  List<MyGarageModel> mygarageModels = List();
  bool showCar = false;

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
    modelCar = myGarageModel.modelCar;
    brandImage = myGarageModel.brandImage;
    pathImage = myGarageModel.pathImage;

    print("My iD Car = ${myGarageModel.id}");

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
    setState(() {
      showCar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
          height: 340.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/garage.png"),
                  fit: BoxFit.cover)),
        ),
        AnimatedPositioned(
          duration: Duration(
            milliseconds: 1000,
          ),
          bottom: showCar ? 350 : 500,
          top: showCar ? 110 : 110,
          right: showCar ? 0 : -200,
          left: showCar ? 0 : 600,
          child: Container(
            // height: 340,
            color: Colors.transparent,
            child: Container(
                // margin: EdgeInsets.all(50.0),
                decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("${MyConstant().domain}$pathImage"),
                  fit: BoxFit.cover),
            )),
          ),
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
                              "${MyConstant().domain}$brandImage")),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 280.0),
            buildCarDetail(),
            myCarInGarage(),
            SizedBox(height: 20.0),
          ],
        ),
        buildTitle(context),
      ]),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Text(
          "$modelCar",
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
                      fontSize: 10.0,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "3.6 Sec",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
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
                      fontSize: 10.0,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "550 HP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
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
                      fontSize: 10.0,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Text(
                  "502 ib-ft",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
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
        itemBuilder: (context, index) => Stack(
          children: [
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
                  child: GestureDetector(
                    onTap: () => selectCar(mygarageModels[index], index),
                  ),
                ),
                Text(
                  "${mygarageModels[index].modelCar}",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Future<Null> selectCar(MyGarageModel myGarageModel, int index) async {
    setState(() {
      print(
          "select Car id = ${myGarageModel.id} and Car Model = ${myGarageModel.modelCar}");
      modelCar = mygarageModels[index].modelCar;
      pathImage = mygarageModels[index].pathImage;
      brandImage = mygarageModels[index].brandImage;
    }
    );
  }
}
