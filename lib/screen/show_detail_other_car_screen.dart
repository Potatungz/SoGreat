import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/widget/show_detail_other_car.dart';

class ShowDetailOtherCarScreen extends StatefulWidget {
  final UserModel userModel;
    final CarModel carModel;
  final GarageModel garageModel;
  final MyGarageModel myGarageModel;
  ShowDetailOtherCarScreen(
      {Key key,
      this.userModel,
      this.carModel,
      this.garageModel,
      this.myGarageModel})
      : super(key: key);
  @override
  _ShowDetailOtherCarScreenState createState() => _ShowDetailOtherCarScreenState();
}

class _ShowDetailOtherCarScreenState extends State<ShowDetailOtherCarScreen> {
   String modelName, urlImage, carDetail;
   UserModel userModel;
  CarModel carModel;
  ShowroomModel showroomModel;
  GarageModel garageModel;
  MyGarageModel myGarageModel;
  Widget detailWidget;
  String idShowroom;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
    carModel = widget.carModel;
    myGarageModel = widget.myGarageModel;
    detailWidget = ShowDetailOtherCar(
      myGarageModel: myGarageModel,
    );
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
            title: MyStyle().showTitleH2(""),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: detailWidget,
        ),
      ],
    );
  }
}