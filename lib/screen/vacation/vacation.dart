// ignore_for_file: prefer_const_constructors

import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/screen/vacation/cards.dart';
import 'package:ez_xpert/screen/vacation/leave_request/leave_request.dart';
import 'package:ez_xpert/screen/vacation/vacation_vm.dart';
import 'package:flutter/material.dart';

class Vacation extends StatefulWidget {
  const Vacation({Key? key}) : super(key: key);

  @override
  _VacationState createState() => _VacationState();
}

class _VacationState extends State<Vacation> with BasePage<VacationVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        floatingActionButton: MaterialButton(
          // minWidth: double.infinity,
          height: 50,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () async {
            var res = await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                contentPadding: EdgeInsets.zero,
                content: LeaveRequest(),
              ),
            );
            if (res == true) {
              provider.getLeave();
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add_circle_rounded,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                "Leave Request",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
          child: ListView.builder(
              itemCount: provider.leave.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 2,
                              ),
                            ],
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: VacationCard(
                                val: "${provider.leaveCount?['earn']}",
                                head: "Earn Leave",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: VacationCard(
                                val: "${provider.leaveCount?['sick']}",
                                head: "Sick Leave",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: VacationCard(
                                val: "${provider.leaveCount?['casual']}",
                                head: "Casual Leave",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: VacationCard(
                                val: "${provider.leaveCount?['other']}",
                                head: "Other Leave",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400]!,
                                blurRadius: 2,
                              ),
                            ],
                            color: Colors.indigo[400],
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                        child: Column(
                          children: [
                            Text(
                              "SELL HOURS : ${provider.sellHour}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400]!,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  height: 70,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${provider.leave[i - 1]['leave_type']}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    decoration: BoxDecoration(
                                        color:
                                            provider.leave[i - 1]['status'] == 0
                                                ? Colors.orange
                                                : provider.leave[i - 1]
                                                            ['status'] ==
                                                        1
                                                    ? Colors.green
                                                    : Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      provider.leave[i - 1]['status'] == 0
                                          ? "Pending"
                                          : provider.leave[i - 1]['status'] == 1
                                              ? "Approved"
                                              : "Rejected",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "${provider.leave[i - 1]['start_date']} - ${provider.leave[i - 1]['end_date']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Total Days",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${provider.leave[i - 1]['duration']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  @override
  VacationVM create() => VacationVM();

  @override
  void initialise(BuildContext context) {}
}
