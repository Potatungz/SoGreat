import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/api/books_api.dart';
import 'package:flutter_sogreat_application/model/book.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/screen/my_garage_screen.dart';
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
  String query = '';
  Timer debouncer;

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

  // Future<Null> readCarAmount() async {
  //   print("read car in garage");
  //   String url = "${MyConstant().domain}/SoGreat/getGarage.php?isAdd=true";
  //   Response response = await Dio().get(url);
  //   print("res ------> $response");

  //   if (response.statusCode == 200) {
  //     final List garages = json.decode(response.data);

  //     return garages
  //         .map((json) => MyGarageModel.fromJson(json))
  //         .where((garage) {
  //       final amountCarLower = garage.idGarage.toLowerCase();
  //       final searchLower = query.toLowerCase();

  //       return amountCarLower.contains(searchLower);
        
  //     }).toList();
  //   } else {
  //     throw Exception();
  //   }
  // }

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
          Expanded(
            child: users.length == 0
                ? MyStyle().showProgress()
                : ListView.builder(
                    itemExtent: 130.0,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return buildGarage(user, index);
                    },
                  ),
          )
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

  Widget buildGarage(UserModel user, int index) => GestureDetector(
        onTap: () {
          print("Tap to Car ID :${users[index].id}");
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => ShowOtherGarageScreen(
              userModel: users[index],
            ),
          );
          Navigator.push(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${MyConstant().domain}${user.urlImage}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.nameGarage,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Text(user.name)
                        ],
                      ),
                    )),
                Expanded(
                  child: Text(
                    "${user.id}",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
