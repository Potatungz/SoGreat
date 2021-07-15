import 'package:flutter/material.dart';
import 'package:flutter_sogreat_application/utility/my_style.dart';

Future<Null> normailDialog(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        title: Text("Waning!!", style: TextStyle(color: MyStyle().primaryColor,fontSize: 20.0 ,fontWeight: FontWeight.bold),),
        subtitle: Text(string),
      ),
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("OK"),
        ),
      ],
    ),
  );
}


