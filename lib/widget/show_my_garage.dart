import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/show_detail_car_screen.dart';
import 'package:flutter_sogreat_application/screen/show_detail_my_car_screen.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowMyGarage extends StatefulWidget {
  final UserModel userModel;
  final MyGarageModel myGarageModel;

  ShowMyGarage({Key key, this.userModel, this.myGarageModel}) : super(key: key);

  @override
  _ShowMyGarageState createState() => _ShowMyGarageState();
}

class _ShowMyGarageState extends State<ShowMyGarage> {
  _getRequests()async{

  }
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
    setState(() {
    });

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return myCarCards.length == 0
        ? MyStyle().showProgress()
        : GridView.extent(
            maxCrossAxisExtent: 210.0,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: myCarCards,
          );
  }

  createCard(MyGarageModel myGarageModel, int index) {
    return GestureDetector(
      onTap: (){
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
            Container(
                height: 150.0,
                color: Colors.transparent,
                child: Image.network(
                  "${MyConstant().domain}${myGarageModel.pathImage}",
                  fit: BoxFit.contain,
                )),
            SizedBox(height: 10.0),
            Container(
              width: 180.0,
              child: MyStyle().showTitleH3White(myGarageModel.modelCar),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
