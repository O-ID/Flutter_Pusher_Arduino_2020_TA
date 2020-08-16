import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pusherflu/claschart.dart';

class StackedBarChart extends StatelessWidget {
  final List<ClassChart> dataf;
  StackedBarChart({@required this.dataf});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ClassChart, String>> seris = [
      charts.Series<ClassChart, String>(
        id: 'Desktop',
        data: dataf,
        domainFn: (ClassChart sales, _) => sales.sensor,
        measureFn: (ClassChart sales, _) => sales.datas,
      )
    ];
    return new charts.BarChart(
      seris,
      animate: true,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }
}
