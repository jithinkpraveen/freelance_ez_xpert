import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ez_xpert/base/base_view_model.dart';
import 'package:ez_xpert/main.dart';
import 'package:ez_xpert/screen/home_main/home_page.dart';
import 'package:ez_xpert/utils/messages.dart';
import 'package:flutter/material.dart';

class LoginVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? email, password;

  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      final response = await api.authRepo.login(email!, password!);
      if (response.runtimeType == Response) {
        if (response.data['sucess'] == "true" ||
            response.data['sucess'] == true) {
          prefs.token = response.data['access_token'].toString();
          // try {
          //   prefs.user = UserModel.fromJson(response.data['user']);
          // } catch (e) {
          //   log("error", error: e);
          // }

          hideLoading();
          Navigator.pushAndRemoveUntil(
              MyApp.context,
              MaterialPageRoute(builder: (context) => const HomePageMain()),
              (route) => false);
        } else {
          hideLoading();
          showError(response.data['message'] ?? Messages.unknownError);
        }
      } else {
        hideLoading();
        showError(Messages.serverError);
      }
    }
  }
}
