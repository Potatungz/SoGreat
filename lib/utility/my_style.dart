import 'package:flutter/material.dart';

class MyStyle {
  Color primaryColor = Color(0xffffc107);
  Color lightColor = Color(0xfffff350);
  Color dardkColor = Color(0xffc79100);

  Stack buildBackground(double screenWidth, double screenHeight) {
    return Stack(children: [
      Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Image(
                image: AssetImage("images/topBG.png"),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

    Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle mainH1Title = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );

  TextStyle mainH2Title = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  TextStyle mainH3Title = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  TextStyle mainBody1 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  TextStyle mainBody2 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  TextStyle subHeader = TextStyle(
    fontSize: 9.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ), textAlign: TextAlign.center,
      );

  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      );

  Text showTitleH3White(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );

  Text showTitleH3Red(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red.shade900,
          fontWeight: FontWeight.w500,
        ),
      );

  Text showTitleH3Purple(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.purple.shade700,
          fontWeight: FontWeight.w500,
        ),
      );

  MyStyle();
}
