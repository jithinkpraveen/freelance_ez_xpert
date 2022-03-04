import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/components/checkin/report_box.dart';
import 'package:ez_xpert/screen/check_in_out/check_in_out_vm.dart';
import 'package:ez_xpert/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class CheckInOut extends StatefulWidget {
  const CheckInOut({Key? key}) : super(key: key);

  @override
  _CheckInOutState createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> with BasePage<CheckInOutVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "TODAY LOG",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                      const Divider(thickness: 1),
                      Visibility(
                        visible: provider.checkinTime != null,
                        child: const Text("Check in time",
                            style: TextStyle(color: Colors.grey)),
                      ),
                      Visibility(
                        visible: provider.checkinTime != null,
                        child: Text(
                          CustomFormat.formatTime(provider.checkinTime),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Visibility(
                        visible: provider.checkOutTime != null &&
                            provider.checkinTime != null,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: provider.checkOutTime != null,
                        child: const Text("Check Out time",
                            style: TextStyle(color: Colors.grey)),
                      ),
                      Visibility(
                        visible: provider.checkOutTime != null,
                        child: Text(
                          CustomFormat.formatTime(provider.checkOutTime),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Visibility(
                        visible: provider.checkOutTime == null ||
                            provider.checkinTime == null,
                        child: MaterialButton(
                          onPressed: () {
                            provider.checkinOrCheckout();
                          },
                          color: Colors.blue,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("     "),
                              Icon(
                                provider.checkinTime == null
                                    ? Icons.play_arrow_rounded
                                    : Icons.stop_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                  " Check ${provider.checkinTime == null ? "In" : "Out"}        ",
                                  style: const TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {
                          provider.emerCheckinOut();
                        },
                        color: Colors.blue,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              provider.emer
                                  ? Icons.stop_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                            Text(
                                provider.emer
                                    ? "Emergency Stop"
                                    : "Emergency Start",
                                style: const TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CalendarCarousel<Event>(
                  customGridViewPhysics: const NeverScrollableScrollPhysics(),
                  onDayPressed: (DateTime date, List<Event> events) {
                    if (provider.attendance.where((element) {
                      return DateTime.parse(element['work_in']).day ==
                              date.day &&
                          DateTime.parse(element['work_in']).month ==
                              date.month &&
                          DateTime.parse(element['work_in']).year == date.year;
                    }).isNotEmpty) {
                      var ele = provider.attendance.where((element) {
                        return DateTime.parse(element['work_in']).day ==
                                date.day &&
                            DateTime.parse(element['work_in']).month ==
                                date.month &&
                            DateTime.parse(element['work_in']).year ==
                                date.year;
                      }).first;
                      DateTime checkin = DateTime.parse(ele['work_in']);
                      DateTime checkOut = DateTime.parse(ele['work_out']);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Center(child: Text('Day Report')),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Check in     :  ${CustomFormat.formatTime(checkin)}"),
                              const SizedBox(height: 5),
                              Text(
                                  "Check Out  :  ${CustomFormat.formatTime(checkOut)}"),
                              const SizedBox(height: 5),
                              Text("OverTime    :  ${ele['ot_hr']}"),
                            ],
                          ),
                          actions: <Widget>[
                            // TextButton(
                            //   onPressed: () => Navigator.pop(context, 'Cancel'),
                            //   child: const Text('Cancel'),
                            // ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  weekendTextStyle: const TextStyle(
                    color: Colors.red,
                  ),

                  thisMonthDayBorderColor: Colors.grey,
                  customDayBuilder: (
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    if (provider.attendance.where((element) {
                      return DateTime.parse(element['work_in']).day ==
                              day.day &&
                          DateTime.parse(element['work_in']).month ==
                              day.month &&
                          DateTime.parse(element['work_in']).year == day.year;
                    }).isNotEmpty) {
                      return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              shape: BoxShape.circle),
                          child: Center(child: Text(day.day.toString())));
                    } else {
                      return null;
                    }
                    // if (day.day == 15) {
                    //   return const Center(
                    //     child: Icon(Icons.local_airport),
                    //   );
                    // } else {
                    //   return null;
                    // }
                  },
                  weekFormat: false,
                  // markedDatesMap: _markedDateMap,
                  height: 420.0,
                  // selectedDateTime: _currentDate,
                  // daysHaveCircularBorder: true,
                ),
                const SizedBox(height: 15),
                const Divider(thickness: 1),
                const SizedBox(height: 10),
                const Text(
                  "EMERGENCY REPORT",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.emergencyWork.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return ReportWidget(data: provider.emergencyWork[i]);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  CheckInOutVM create() => CheckInOutVM();

  @override
  void initialise(BuildContext context) {}
}
