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

// ignore: must_be_immutable
//class StackedBarChart extends StatefulWidget {
// final List<charts.Series> seriesList;
// final bool animate;
//final List<ClassChart> data;
//StackedBarChart({@required this.data});

// StackedBarChart(this.seriesList, {this.animate});
//@override
//_StackedBarChartState createState() => _StackedBarChartState();

/// Create series list with multiple series
// static List<charts.Series<ClassChart, String>> _createSampleData() {
//   final desktopSalesData = [
//     new ClassChart(sensor: 'DHT 1', datas: 19),
//     new ClassChart(sensor: 'DHT 2', datas: 29),
//     new ClassChart(sensor: 'DHT 3', datas: 39),
//     new ClassChart(sensor: 'DHT 4', datas: 49),
//     new ClassChart(sensor: 'DHT 5', datas: 59),
//     new ClassChart(sensor: 'DHT 6', datas: 69),
//     new ClassChart(sensor: 'AIR', datas: 79),
//   ];
//   // return [
//   //   new charts.Series<ClassChart, String>(
//   //       id: 'Desktop',
//   //       domainFn: (ClassChart sales, _) => sales.sensor,
//   //       measureFn: (ClassChart sales, _) => sales.datas,
//   //       data: desktopSalesData,
//   //       // labelAccessorFn: (OrdinalSales row, _) => row.sales.toString(),
//   //       // colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault),
//   // ];
// }
//}

// class _StackedBarChartState extends State<StackedBarChart> {
//   List<charts.Series<ClassChart, String>> seris = [
//     charts.Series<ClassChart, String>(
//       id: 'Desktop',
//       data: data,
//       domainFn: (ClassChart sales, _) => sales.sensor,
//       measureFn: (ClassChart sales, _) => sales.datas,
//     )
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return new charts.BarChart(
//       seris,
//       animate: true,
//       barGroupingType: charts.BarGroupingType.stacked,
//     );
//   }
// }

/// Sample ordinal data type.
// class OrdinalSales {
//   final String year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }
