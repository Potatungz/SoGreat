import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Future<Null> showToast(BuildContext context, String msg,
    {int duration, int gravity}) async {
  Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: Colors.white54, textColor: Colors.black);
}
