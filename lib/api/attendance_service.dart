import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ez_xpert/api/api_config.dart';

abstract class AttendanceRepo {
  factory AttendanceRepo(Dio dio) = _AttendanceServices;
  Future<dynamic> checkInOut();
  Future<dynamic> emergCheckInOut();
}

class _AttendanceServices implements AttendanceRepo {
  _AttendanceServices(this._dio);
  final Dio _dio;

  @override
  Future checkInOut() async {
    try {
      var res = await _dio.get(ApiConfig.attendanceInOut);
      return res;
    } catch (e) {
      log("error api call login", error: e);
      return false;
    }
  }

  @override
  Future emergCheckInOut() async {
    try {
      var res = await _dio.get(ApiConfig.emerAttendanceInOut);
      return res;
    } catch (e) {
      log("error api call login", error: e);
      return false;
    }
  }
}
