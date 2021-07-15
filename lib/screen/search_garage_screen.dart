import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/show_other_garage_screen.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:flutter_sogreat_application/widget/search_widget.dart';
import 'package:flutter_sogreat_application/api/garages_api.dart';

class SearchGarageScreen extends StatefulWidget {
  final MyGarageModel myGarageModel;
  SearchGarageScreen({Key key, this.myGarageModel}) : super(key: key);
  @override
  _SearchGarageScreenState createState() => _SearchGarageScreenState();
}

class _SearchGarageScreenState extends State<SearchGarageScreen> {
  MyGarageModel myGarageModel;
  List<MyGarageModel> garages = List();
  List<UserModel> users = List();
  List<String> listAmount = List();
  String query = '';
  Timer debouncer;

  String idGarage;

  @override
  void initState() {
    super.initState();
    myGarageModel = widget.myGarageModel;
    init();
  }

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future<Null> init() async {
    final users = await FindGaragesApi.getUsers(query);

    setState(() {
      this.users = users;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FIND GARAGE",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          buildSearch(),
          Container(padding: EdgeInsets.only(top:8.0, bottom: 16.0,left: 24.0 ,right: 24.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(flex: 5,child: AutoSizeText("Garages",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700,),minFontSize: 14,maxFontSize: 18.0,)),
                Expanded(flex: 1,child: Center(child: AutoSizeText("Cars",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w700),minFontSize: 14.0,maxFontSize: 18.0,))),
              ],
            ),
          ),
          Expanded(
            child: users.length == 0
                ? MyStyle().showProgress()
                : ListView.builder(
                    itemExtent: 120,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          )),
                          child: buildGarage(user, index));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: "Garage Name or Name",
        onChanged: searchGarage,
      );
  Future<Null> searchGarage(String query) async => debounce(() async {
        final users = await FindGaragesApi.getUsers(query);

        if (!mounted) return;
        setState(() {
          this.query = query;
          this.users = users;
        });
      });

  Widget buildGarage(UserModel user, int index) => FlatButton(
        onPressed: () {
          print("Tap to Car ID :${users[index].id}");
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => ShowOtherGarageScreen(
              userModel: users[index],
            ),
          );
          Navigator.push(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${MyConstant().domain}${user.urlImage}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.0, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: AutoSizeText(
                            user.nameGarage.isEmpty
                                ? "No NAME"
                                : "${user.nameGarage}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            minFontSize: 12.0,
                            maxFontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01),
                        AutoSizeText(
                          user.name,
                          style: TextStyle(
                              fontSize: 10.0, color: Colors.grey.shade500),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: FittedBox(
                          child: AutoSizeText(
                            "${user.carAmount}",
                            style: TextStyle(
                                fontSize: 38, fontWeight: FontWeight.w100,color: MyStyle().primaryColor),
                            minFontSize: 36,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
