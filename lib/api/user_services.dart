import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ez_xpert/api/api_config.dart';

abstract class UserRepo {
  factory UserRepo(Dio dio) = _UserServices;
  Future<dynamic> getUserData();
  Future<dynamic> getAttendance();
  Future<dynamic> updateProfile(FormData body);
}

class _UserServices implements UserRepo {
  _UserServices(this._dio);
  final Dio _dio;

  @override
  Future getUserData() async {
    try {
      var res = await _dio.get(ApiConfig.getUserData);
      return res;
    } catch (e) {
      log("error api call login", error: e);
      return false;
    }
  }

  @override
  Future getAttendance() async {
    try {
      var res = await _dio.get(ApiConfig.getattendance);
      return res;
    } catch (e) {
      log("error api call login", error: e);
      return false;
    }
  }

  @override
  Future updateProfile(FormData body) async {
    try {
      var res = await _dio.post(ApiConfig.updateProfile, data: body);
      return res;
    } catch (e) {
      log("error api call login", error: e);
      return false;
    }
  }
}
