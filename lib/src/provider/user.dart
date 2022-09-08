import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe_app/src/model/User.dart';

class UserProvider extends ChangeNotifier {

  List<User> users = [];
  static List<dynamic> _usersData = [];

  //////////////// Singleton Constructor ///////////////////
  static final UserProvider _singleton = UserProvider._internal();

  factory UserProvider() {
    return _singleton;
  }

  UserProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  
  Future<List<User>> getUsers() async {
    await loadUsersFromAsset();
    users.clear();
    _usersData.forEach((element) {
      users.add(User.fromMap(element));
    });
    print('_users ${users.toString()}');

    return users;
  }

  loadUsersFromAsset() async {
    String jsonContent = await rootBundle.loadString('assets/consts/users.json');
    _usersData = json.decode(jsonContent);
    notifyListeners();
  }
  
}
