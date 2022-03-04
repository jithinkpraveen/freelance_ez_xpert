import 'package:dio/dio.dart';
import 'package:ez_xpert/base/base_view_model.dart';
import 'package:ez_xpert/model/user_model.dart';
import 'package:ez_xpert/screen/check_in_out/check_in_out.dart';
import 'package:ez_xpert/screen/home/home.dart';
import 'package:ez_xpert/screen/profile/profile.dart';
import 'package:ez_xpert/screen/vacation/vacation.dart';
import 'package:flutter/material.dart';

class HomePageMainVM extends BaseViewModel {
  @override
  void onInit() {
    getuser();
  }

  int curentIndex = 0;
  void changeIndex(val) {
    curentIndex = val;
    notifyListeners();
  }

  void getuser() async {
    Response response = await api.profileRepo.getProfile();
    UserModel user = UserModel.fromJson(response.data['result']);
    prefs.user = user;
  }

  Widget buildHome() {
    switch (curentIndex) {
      case 0:
        return Home(function: changeIndex);
      case 1:
        return const CheckInOut();
      case 2:
        return const Profile();
      case 3:
        return const Vacation();
      default:
        return const Home();
    }
  }
}
