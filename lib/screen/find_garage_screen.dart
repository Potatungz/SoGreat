import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindGarageScreen extends StatefulWidget {
  final UserModel userModel;
  FindGarageScreen({
    Key key,
    this.userModel,
  }) : super(key: key);
  @override
  _FindGarageScreenState createState() => _FindGarageScreenState();
}

class _FindGarageScreenState extends State<FindGarageScreen>
//  with SingleTickerProviderStateMixin
{
  UserModel userModel;
  TextEditingController editingController = TextEditingController();
  TabController controller;
  List<UserModel> userModels = List();

  // List<String> listItems = [
  //   "Tispol",
  //   "Mario",
  //   "Nadech",
  //   "Bonus",
  //   "Cherprang",
  //   "Mobile",
  //   "Jenny",
  //   "Alex",
  // ];
  var items = List<UserModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.addAll(userModels);
    userModel = widget.userModel;
    // controller = new TabController(length: 10, vsync: this);
  }

  Future<Null> readGarage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(15.0),
                      child: TextField(
                        onChanged: (value) {
                          filterSearchResults(value);
                          print("value :" + value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 25.0,
                          ),
                          contentPadding:
                              EdgeInsets.only(left: 10.0, top: 12.0),
                          hintText: "Search garage",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20.0),
              MyStyle().showTitleH2("GARAGE"),
            ],
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {}

  Widget buildCell(BuildContext context, int index, String name) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => GestureDetector(
              child: Container(
                color: Colors.grey,
                alignment: Alignment.center,
                child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width / 6,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${MyConstant().domain}${userModel.urlImage}"))),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 5.0),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Garage Name",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "name",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.normal),
                        ),
                        Row(children: <Widget>[
                          Text(
                            "*****",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "4.0",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          )
                        ])
                      ],
                    ),
                  )
                ]),
              ),
            ));
  }
}
