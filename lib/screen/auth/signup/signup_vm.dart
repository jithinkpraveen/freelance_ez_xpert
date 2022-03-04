import 'package:dio/dio.dart';
import 'package:ez_xpert/base/base_view_model.dart';
import 'package:ez_xpert/main.dart';
import 'package:ez_xpert/utils/messages.dart';
import 'package:flutter/material.dart';

class SignupVM extends BaseViewModel {
  @override
  void onInit() {}
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  String? email, password, name, address;
  void visiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showLoading();
      final response =
          await api.authRepo.signup(email!, password!, name!, address ?? "");
      if (response.runtimeType == Response) {
        if (response.data['sucess'] == "true" ||
            response.data['sucess'] == true) {
          Navigator.pop(MyApp.context);
          showNotification("User Created");
        } else {
          showError(response.data["message"] ?? Messages.unknownError);
        }
      } else {
        showError(Messages.serverError);
      }

      hideLoading();
    }
  }
}
