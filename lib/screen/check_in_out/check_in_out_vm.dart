import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ez_xpert/base/base_view_model.dart';

class CheckInOutVM extends BaseViewModel {
  @override
  void onInit() {
    getAttendance();
  }

  DateTime? checkinTime;
  DateTime? checkOutTime;
  bool emer = false;

  void checkinOrCheckout() async {
    if (checkinTime == null) {
      showLoading();
      final response = await api.attendanceRepo.checkInOut();
      hideLoading();
      if (response.runtimeType == Response) {
        checkinTime = DateTime.now();
        notifyListeners();
      } else {
        changeState(ChangeState.serverError);
      }
    } else {
      showLoading();
      final response = await api.attendanceRepo.checkInOut();
      hideLoading();
      if (response.runtimeType == Response) {
        checkOutTime = DateTime.now();
        notifyListeners();
      } else {
        changeState(ChangeState.serverError);
      }
    }
  }

  emerCheckinOut() async {
    showLoading();
    final response = await api.attendanceRepo.emergCheckInOut();
    hideLoading();
    if (response.runtimeType == Response) {
      emer = !emer;
      if (emer == false) {
        getAttendance();
      }
      notifyListeners();
    } else {
      changeState(ChangeState.serverError);
    }
  }

  List attendance = [];
  List emergencyWork = [];
  void getAttendance() async {
    showLoading();
    final response = await api.userRepo.getAttendance();
    hideLoading();

    if (response.runtimeType == Response) {
      attendance = response.data['result']['attendance_details'] ?? [];
      emergencyWork = response.data['result']['emergency_report'] ?? [];
      try {
        if (attendance.where((element) {
          return element['work_in']
              .toString()
              .contains(DateTime.now().toString().substring(0, 9));
        }).isNotEmpty) {
          checkinTime = DateTime.parse(attendance.last['work_in']);
          if (attendance.last['work_in'] != attendance.last['work_out']) {
            checkOutTime = DateTime.parse(attendance.last['work_out']);
          }
        }
      } catch (e) {
        log("error check in out", error: e);
      }

      try {
        if (emergencyWork.last['start_time'] ==
            emergencyWork.last['end_time']) {
          emer = true;
          notifyListeners();
        }
      } catch (e) {
        log("error check in out", error: e);
      }

      notifyListeners();
    } else {
      changeState(ChangeState.serverError);
    }
  }
}
