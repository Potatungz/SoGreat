import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/build_garage_screen.dart';
import 'package:flutter_sogreat_application/screen/show_detail_my_car_screen.dart';
import 'package:flutter_sogreat_application/screen/showroom_screen.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowMyGarage extends StatefulWidget {
  final UserModel userModel;
  final MyGarageModel myGarageModel;

  ShowMyGarage({Key key, this.userModel, this.myGarageModel}) : super(key: key);

  @override
  _ShowMyGarageState createState() => _ShowMyGarageState();
}

class _ShowMyGarageState extends State<ShowMyGarage> {
  _getRequests() async {}
  UserModel userModel;
  MyGarageModel myGarageModel;
  CarModel carModel;
  String idGarage, pathImage;
  List<UserModel> userModels = List();
  List<MyGarageModel> myGarageModels = List();
  List<Widget> myCarCards = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
    myGarageModel = widget.myGarageModel;
    readMyGarage();
  }

  Future<Null> onGoBack(dynamic value) async {
    print("Go Back");
    readMyGarage();
    setState(() {});
  }

  Future<Null> readMyGarage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idGarage = preferences.getString("id");

    print("id Garage = $idGarage");

    String url =
        "${MyConstant().domain}/SoGreat/getCarWhereIdGarage.php?isAdd=true&idGarage=$idGarage";

    print("$url");
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;
      for (var map in result) {
        MyGarageModel model = MyGarageModel.fromJson(map);
        String modelCar = model.modelCar;
        // String urlImage = model.urlImage;
        if (modelCar.isNotEmpty) {
          print("Brand Name = ${model.modelCar}");
          print("PathImage = ${model.pathImage}");
          setState(() {
            myGarageModels.add(model);
            myCarCards.add(
              createCard(model, index),
            );
            index++;
          });
        }
      }
      print("Car Amount Now!! = ${myGarageModels.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return myCarCards.length == 0
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Icon(
                  FontAwesomeIcons.carAlt,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
              FittedBox(
                child: Text(
                  "There are no car in the garage",
                  style: MyStyle().mainH3Title,
                ),
              ),SizedBox(height: 20.0),
              RaisedButton(padding: EdgeInsets.all(8.0),
                child: Text("ADD CAR"),color: MyStyle().primaryColor,
                onPressed: () {
                     MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => ShowRoomScreen(),
              );
              Navigator.push(context, route);
                },
              )
            ],
          ))
        : GridView.extent(
            maxCrossAxisExtent: 220.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: myCarCards,
          );
  }

  createCard(MyGarageModel myGarageModel, int index) {
    return GestureDetector(
      onTap: () {
        print("Tap to Index = $index");
        print("Tap to Car ID :${myGarageModels[index].idCar}");
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowDetailMyCarScreen(
            myGarageModel: myGarageModels[index],
          ),
        );
        Navigator.pushReplacement(context, route).then(onGoBack);
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                  // height: MediaQuery.of(context).size.height*0.2,
                  color: Colors.transparent,
                  child: Image.network(
                    "${MyConstant().domain}${myGarageModel.pathImage}",
                    fit: BoxFit.contain,
                  )),
            ),
            // SizedBox(height: 10.0),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                width: 200.0,
                child: AutoSizeText(
                  "${myGarageModel.modelCar}",
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
            // SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
