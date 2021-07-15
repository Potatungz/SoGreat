import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/show_detail_car_screen.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowListCar extends StatefulWidget {
  final CarModel carModel;
  final ShowroomModel showroomModel;
  ShowListCar({
    Key key,
    this.showroomModel,
    this.carModel,
  }) : super(key: key);

  @override
  _ShowListCarState createState() => _ShowListCarState();
}

class _ShowListCarState extends State<ShowListCar> {
  CarModel carModel;
  ShowroomModel showroomModel;
  MyGarageModel myGarageModel;
  String idShowroom,
      showroomName,
      urlImage,
      brandName,
      modelName,
      pathImage,
      brandImage;
  List<CarModel> carModels = List();

  @override
  void initState() {
    super.initState();
    carModel = widget.carModel;
    showroomModel = widget.showroomModel;
    readCarList();
  }

  Future<Null> readCarList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    showroomName = preferences.getString("showroomName");
    urlImage = preferences.getString("URLImage");
    idShowroom = preferences.getString("idShowroom");
    brandName = preferences.getString("brandName");
    modelName = preferences.getString("modelName");
    pathImage = preferences.getString("pathImage");
    brandImage = preferences.getString("brandImage");

    idShowroom = showroomModel.id;
    String url =
        "${MyConstant().domain}/SoGreat/getCarWhereIdShowroom.php?isAdd=true&idShowroom=$idShowroom";

    Response response = await Dio().get(url);
    print("res --> $response");

    var result = json.decode(response.data);
    print("result = $result");

    for (var map in result) {
      CarModel carModel = CarModel.fromJson(map);
      setState(() {
        carModels.add(carModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return carModels.length == 0
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: carModels.length,
            itemBuilder: (context, index) => GestureDetector(
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.85,

                margin: EdgeInsets.only(
                    top: 6.0, bottom: 6.0, left: 12.0, right: 12.0),
                padding: EdgeInsets.only(
                    top: 6.0, bottom: 12.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  color: Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Transform.scale(
                        scale: 1.25,
                        child: Image.network(
                          "${MyConstant().domain}${carModels[index].pathImage}",
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            flex: 5,
                            child: Column(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: AutoSizeText(
                                      carModels[index].modelName,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.start,maxLines: 1,minFontSize: 16,
                                    )),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: AutoSizeText(
                                      carModels[index].modelName,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,maxLines: 2,minFontSize: 10,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Flexible(flex: 1, child: addCar(carModel, index))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                print("Tap to Car ID :${carModels[index].id}");
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => ShowDetailCarScreen(
                    carModel: carModels[index],
                  ),
                );
                Navigator.push(context, route);
              },
            ),
          );
  }

  Widget addCar(CarModel carModel, int index) {
    return Container(
      child: FloatingActionButton(
        heroTag: "${carModels[index].id}",
        child: Icon(Icons.add, color: Colors.black87, size: 30),
        backgroundColor: Colors.white,
        onPressed: () {
          print(carModels[index].id);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => ShowDetailCarScreen(
              carModel: carModels[index],
            ),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }
}
