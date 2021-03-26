import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/widget/show_list_car.dart';

class ShowCarListScreen extends StatefulWidget {
  final CarModel carModel;
  final ShowroomModel showroomModel;

  ShowCarListScreen({Key key, this.carModel, this.showroomModel})
      : super(key: key);

  @override
  _ShowCarListScreenState createState() => _ShowCarListScreenState();
}

class _ShowCarListScreenState extends State<ShowCarListScreen> {
  CarModel carModel;
  ShowroomModel showroomModel;
  Widget listWidgets;
  String idShowroom;

  @override
  void initState() {
    super.initState();
    // carModel = widget.carModel;
    showroomModel = widget.showroomModel;
    listWidgets = ShowListCar(
      showroomModel: showroomModel,
    );
    // listWidgets.add(ShowListCar(carModel: carModel));
    // listWidgets.add(ShowListCar(showroomModel: showroomModel));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xffF1F1F1),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: MyStyle().showTitleH2(showroomModel.showroomName),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: listWidgets,
        ),
      ],
    );
  }
}
