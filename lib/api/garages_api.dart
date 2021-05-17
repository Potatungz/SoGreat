import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:flutter_sogreat_application/model/user_model.dart';
import 'package:flutter_sogreat_application/utility/my_constant.dart';

class FindGaragesApi {
  static Future<List<UserModel>> getUsers(String query) async {
    String url =
        "${MyConstant().domain}/SoGreat/getUser.php?isAdd=true";
    Response response = await Dio().get(url);
    print("res ------> $response");
    
    if (response.statusCode == 200) {
      final List users = json.decode(response.data);

      return users.map((json) => UserModel.fromJson(json)).where((user) {
        final titleLower = user.nameGarage.toLowerCase();
        final authorLower = user.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

