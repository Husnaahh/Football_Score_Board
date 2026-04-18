// lib/controller/user_controller.dart
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/user_service.dart';   // ← import your service

class UserController extends ChangeNotifier {
  final UserService userService = UserService();

  UserModel? userModel;

  Future<void> loadUser(String uid) async {
    userModel = await userService.getUser(uid);
    notifyListeners();
  }

  Future<void> createUser(UserModel user) async {
    await userService.createUser(user);
    userModel = user;
    notifyListeners();
  }
}