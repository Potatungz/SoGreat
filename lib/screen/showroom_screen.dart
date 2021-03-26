import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/garage_model.dart';

import 'package:flutter_sogreat_application/screen/show_list_showroom_all.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';

class ShowRoomScreen extends StatefulWidget {
  final GarageModel garageModel;
   ShowRoomScreen({Key key, this.garageModel,}) : super(key: key);

  @override
  _ShowRoomScreenState createState() => _ShowRoomScreenState();
}

class _ShowRoomScreenState extends State<ShowRoomScreen> {
  Widget currentWidget;  
  String idShowroom;

@override
  void initState() {
    super.initState();
    currentWidget = ShowListShowroomAll();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ShaderMask(
        shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black38, Colors.transparent]).createShader(rect),
        blendMode: BlendMode.darken,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage("images/garage.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ))),
      ),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(color: Colors.black.withOpacity(0)),
        ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: MyStyle().showTitle("SHOWROOM"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),body: currentWidget,
        // body: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Center(
        //           child: Text(
        //         "Showroom Screen",
        //         style: MyStyle().mainH1Title,
        //       )),
        //       SizedBox(height: 30.0),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Container(
        //               margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //               width: 140.0,
        //               height: 140.0,
        //               decoration: BoxDecoration(color: MyStyle().primaryColor),
        //               child: FlatButton(
        //                   onPressed: () {
        //                     idShowroom = "31";
        //                     checkShowroom();
        //                   },
        //                   child: Text("Benz AMG"))),
        //           Container(
        //             margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //             width: 140.0,
        //             height: 140.0,
        //             decoration: BoxDecoration(color: MyStyle().primaryColor),
        //             child: FlatButton(onPressed: () {
        //               idShowroom = "21";
        //                     checkShowroom();
        //             }, child: Text("Ferrari")),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Container(
        //             margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //             width: 140.0,
        //             height: 140.0,
        //             decoration: BoxDecoration(color: MyStyle().primaryColor),
        //             child:
        //                 FlatButton(onPressed: () {
        //                   idShowroom = "32";
        //                     checkShowroom();
        //                 }, child: Text("Lamboghini")),
        //           ),
        //           Container(
        //             margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //             width: 140.0,
        //             height: 140.0,
        //             decoration: BoxDecoration(color: MyStyle().primaryColor),
        //             child: FlatButton(onPressed: () {}, child: Text("Porshe")),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Container(
        //             margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //             width: 140.0,
        //             height: 140.0,
        //             decoration: BoxDecoration(color: MyStyle().primaryColor),
        //             child: FlatButton(onPressed: () {}, child: Text("McLaren")),
        //           ),
        //           Container(
        //             margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //             width: 140.0,
        //             height: 140.0,
        //             decoration: BoxDecoration(color: MyStyle().primaryColor),
        //             child: FlatButton(onPressed: () {}, child: Text("Audi")),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Container(
        //               margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //               width: 140.0,
        //               height: 140.0,
        //               decoration: BoxDecoration(color: MyStyle().primaryColor),
        //               child:
        //                   FlatButton(onPressed: () {}, child: Text("Bugatti"))),
        //           Container(
        //               width: 140.0,
        //               height: 140.0,
        //               decoration: BoxDecoration(color: MyStyle().primaryColor),
        //               child: FlatButton(
        //                   onPressed: () {}, child: Text("Koenigsegg"))),
        //         ],
        //       ),
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //         Container(
        //             width: 140.0,
        //             height: 140.0,
        //             decoration: BoxDecoration(color: MyStyle().primaryColor),
        //             child: FlatButton(onPressed: () {}, child: Text("Pagani"))),
        //         Container(
        //           margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        //           width: 140.0,
        //           height: 140.0,
        //           decoration: BoxDecoration(color: Colors.transparent),
        //           // child: Text("Pagani"),
        //         ),
        //       ]),
        //       SizedBox(height: 20.0),
        //     ],
        //   ),
        // ),
      ),
    ]);
  }
  // Future<Null> checkShowroom() async {
  //   String url =
  //       "${MyConstant().domain}/SoGreat/getCarWhereIdShowroom.php?isAdd=true&idShowroom=$idShowroom";
  //   try {
  //     Response response = await Dio().get(url);
  //     print("res = $response");

  //     var result = json.decode(response.data);
  //     print("result = $result");

  //     for (var map in result) {
  //       CarModel carModel = CarModel.fromJson(map);
  //       if (idShowroom == carModel.idShowroom) {
  //         routeToListCar(ShowListCars(), carModel);
  //       } 
  //     }
  
  //   } catch (e) {}
  // }

  // Future<Null> routeToListCar(Widget myWidget, CarModel carModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString("idShowroom", carModel.idShowroom);
  //   preferences.setString("brandName", carModel.brandName);
  //   preferences.setString("modelName", carModel.modelName);
  //   preferences.setString("pathUmage", carModel.pathImage);

  //   print("Enter to routeToLsitCar");
  //   MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
  //   Navigator.push(context, route).then((value) => ShowListCars());
  //   // Navigator.pushAndRemoveUntil(context, route, (route) => false);
  // }
}
