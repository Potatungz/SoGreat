import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/car_model.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/showroom_model.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/widget/show_detail_car.dart';

class ShowDetailCarScreen extends StatefulWidget {
  final CarModel carModel;
  final ShowroomModel showroomModel;
  final GarageModel garageModel;
  final MyGarageModel myGarageModel;
  ShowDetailCarScreen({Key key, this.carModel,this.showroomModel, this.garageModel, this.myGarageModel}) : super(key: key);

  @override
  _ShowDetailCarScreenState createState() => _ShowDetailCarScreenState();
}

class _ShowDetailCarScreenState extends State<ShowDetailCarScreen> {
  String modelName, urlImage, carDetail;
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
    carModel = widget.carModel;
    showroomModel = widget.showroomModel;
    detailWidget = ShowDetailCar(
    carModel: carModel,
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
            title: MyStyle().showTitleH2(carModel.modelName),
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
