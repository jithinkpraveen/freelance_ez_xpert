import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key, required this.title, required this.data})
      : super(key: key);
  final List data;
  final String title;

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: widget.title),
        legend: Legend(isVisible: true, position: LegendPosition.top),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          StackedColumnSeries<ExpenseData, String>(
              dataSource: _chartData,
              xValueMapper: (ExpenseData exp, _) => exp.date,
              yValueMapper: (ExpenseData exp, _) => exp.regular,
              name: 'Regular',
              markerSettings: const MarkerSettings(
                isVisible: true,
              )),
          StackedColumnSeries<ExpenseData, String>(
              dataSource: _chartData,
              xValueMapper: (ExpenseData exp, _) => exp.date,
              yValueMapper: (ExpenseData exp, _) => exp.overTime,
              name: 'Overtime',
              markerSettings: const MarkerSettings(
                isVisible: true,
              )),
          StackedColumnSeries<ExpenseData, String>(
              dataSource: _chartData,
              xValueMapper: (ExpenseData exp, _) => exp.date,
              yValueMapper: (ExpenseData exp, _) => exp.emergency,
              name: 'Emgerency',
              markerSettings: const MarkerSettings(
                isVisible: true,
              )),
        ],
        primaryXAxis: CategoryAxis(),
      ),
    ));
  }

  List<ExpenseData> getChartData() {
    // final List<ExpenseData> chartData = [
    //   ExpenseData('13', 40, 40, 45),
    //   ExpenseData('14', 40, 0, 54),
    //   ExpenseData('15', 40, 0, 20),
    //   ExpenseData('16', 40, 0, 23),
    //   ExpenseData('17', 40, 18, 0),
    //   ExpenseData('18', 40, 54, 0),
    // ];

    final List<ExpenseData> chartData = widget.data
        .map((e) => ExpenseData(
            date: e['date']
                .toString()
                .substring(0, (e['date'].toString().length - 5)),
            emergency: e['emrge_time'],
            overTime: e['over_time'],
            regular: e['regular_time']))
        .toList();
    log(chartData.toString());
    return chartData;
  }
}

class ExpenseData {
  ExpenseData({
    required this.date,
    required this.regular,
    required this.overTime,
    required this.emergency,
  });
  final String date;
  final num regular;
  final num overTime;
  final num emergency;
}
