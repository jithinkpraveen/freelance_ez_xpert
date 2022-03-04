import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/components/home/bar_chart.dart';
import 'package:ez_xpert/components/home/home_page_card.dart';
import 'package:ez_xpert/screen/home/home_vm.dart';
import 'package:ez_xpert/screen/time_sheet/time_sheet.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.function}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final function;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with BasePage<HomeVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.function(1);
                      },
                      child: HomeCard(
                        color: Colors.yellow[600]!,
                        val: "${provider.data?['attendance']} DAYS",
                        head: "ATTENDANCE",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.function(1);
                      },
                      child: HomeCard(
                        color: Colors.orange[600]!,
                        val:
                            "${provider.data?['working_hours'] ?? "00:00:00"} /HR",
                        head: "WORKING HOURS",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TimeSheet(),
                          ),
                        );
                      },
                      child: HomeCard(
                        color: Colors.green[600]!,
                        val: "\$ ${provider.data?['salary_received']}",
                        head: "SALARY RECEIVED",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TimeSheet(),
                          ),
                        );
                      },
                      child: HomeCard(
                        color: Colors.indigo[400]!,
                        val: "\$ ${provider.data?['my_salary']}",
                        head: "MY\nSALARY",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.function(3);
                      },
                      child: HomeCard(
                        color: Colors.red[400]!,
                        val:
                            "${provider.data?['taken_leave']}/${provider.data?['total_leave']}",
                        head: "MY VACATION",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: provider.isloading
                    ? Chart(
                        key: Key(provider.isloading ? "1" : "0"),
                        title: "DAILY PERFORMANCE",
                        data: const [],
                      )
                    : Chart(
                        key: Key(provider.isloading ? "1" : "0"),
                        title: "DAILY PERFORMANCE",
                        data: provider.data?['daily_performance'] ?? [],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeVM create() => HomeVM();

  @override
  void initialise(BuildContext context) {}
}
