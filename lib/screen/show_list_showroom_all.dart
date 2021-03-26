import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/screen/show_car_list_screen.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowListShowroomAll extends StatefulWidget {
  @override
  _ShowListShowroomAllState createState() => _ShowListShowroomAllState();
}

class _ShowListShowroomAllState extends State<ShowListShowroomAll> {
  String showroomName, urlImage, idShowroom;
  List<ShowroomModel> showroomModels = List();
  List<CarModel> carModels = List();
  List<Widget> showroomCards = List();

  @override
  void initState() {
    super.initState();
    readShowroom();
  }

  Future<Null> readShowroom() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    showroomName = preferences.getString("showroomName");
    urlImage = preferences.getString("URLImage");

    idShowroom = preferences.getString("idShowroom");

    print("Enter ReadShowroom");
    String url =
        "${MyConstant().domain}/SoGreat/getShowroomWhereChooseType.php?isAdd=true&ChooseType=Showroom";

    print("$url");
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;
      for (var map in result) {
        ShowroomModel model = ShowroomModel.fromJson(map);
        String showroomName = model.showroomName;
        // String urlImage = model.urlImage;
        if (showroomName.isNotEmpty) {
          print("Brand Name = ${model.showroomName}");
          setState(() {
            showroomModels.add(model);
            showroomCards.add(
              createCard(model, index),
            );
            index++;
          });
        }
      }
    });
  }

  Widget createCard(ShowroomModel showroomModel, int index) {
    return GestureDetector(
      onTap: () {
        print('You Click index $index');
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowCarListScreen(
            showroomModel: showroomModels[index],
          ),
        );
        Navigator.push(context, route);
      },
      child: Card(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 120,
                height: 120,
                color: Colors.transparent,
                child: Image.network(
                  "${MyConstant().domain}${showroomModel.urlImage}",
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 10.0),
            Container(
              width: 120,
              child: MyStyle().showTitleH2(showroomModel.showroomName),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return showroomCards.length == 0
        ? MyStyle().showProgress()
        : GridView.extent(
            maxCrossAxisExtent: 210.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: showroomCards,
          );
  }
}
