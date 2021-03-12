import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowListCars extends StatefulWidget {
  // final CarModel carModel;
  // ShowListCars({Key key, this.carModel}):super(key: key);
  @override
  _ShowListCarsState createState() => _ShowListCarsState();
}

class _ShowListCarsState extends State<ShowListCars> {
  String idShowroom, brandName, modelName, pathImage;
  CarModel carModel;

  bool loadStatus = true;
  bool status = true;
  List<CarModel> carModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCarModel();
  }

  Future<Null> readCarModel() async {
    if (carModels.length != 0) {
      loadStatus = true;
      status = true;
      carModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idShowroom = carModel.idShowroom;
    idShowroom = preferences.getString("idShowroom");
    brandName = preferences.getString("brandName");
    modelName = preferences.getString("modelName");
    pathImage = preferences.getString("pathImage");
    print("idShowroom = $idShowroom");
    print("brandName = $brandName");
    print("modelName = $modelName");
    print("pathImage = $pathImage");

    String url =
        "${MyConstant().domain}/SoGreat/getCarWhereIdShowroom.php?isAdd=true&idShowroom=$idShowroom";
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });
      // Response response = await Dio().get(url);
      // print("Response = $response");

      if (value.toString() != "null") {
        var result = json.decode(value.data);

        for (var map in result) {
          CarModel carModel = CarModel.fromJson(map);
          setState(() {
            carModels.add(carModel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
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
        body: Stack(
          children: <Widget>[
            loadStatus ? MyStyle().showProgress() : showContent()
          ],
        ));
  }

  Widget showContent() {
    return status ? showListCar() : Center(child: Text("No Data"));
  }

  Widget showListCar() => ListView.builder(
        itemCount: carModels.length,
        itemBuilder: (context, index) => Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 12, bottom: 12),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.2,
                color: MyStyle().primaryColor,
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(child: pathImage == null ? Text("No Image") :Image.network("${MyConstant().domain}${carModels[index].pathImage}"),),
                    ],
                  ),
                  Text(carModels[index].modelName)
                ])),
          ],
        ),
      );
}
