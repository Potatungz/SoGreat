import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';

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
    with SingleTickerProviderStateMixin {
  UserModel userModel;
  TextEditingController editingController = TextEditingController();
  TabController controller;
  List<UserModel> userModels = List();
  var items = List<UserModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.addAll(userModels);
    userModel = widget.userModel;
    controller = new TabController(length: 4, vsync: this);
  }

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
      body: new Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
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
          new Expanded(
            child: new ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {return buildCell(context, index,items[index]);},
                          ),
                        )
                      ],
                    ),
                  );
                }
              
                void filterSearchResults(String query) {}
              
                Widget buildCell(BuildContext context, int index, UserModel item) {

                }
}
