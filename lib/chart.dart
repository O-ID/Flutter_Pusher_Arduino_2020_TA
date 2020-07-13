import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedBarChart(this.seriesList, {this.animate});

  factory StackedBarChart.withSampleData() {
    return new StackedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('Janurari', 5),
      new OrdinalSales('Februari', 25),
      new OrdinalSales('Maret', 20),
      new OrdinalSales('April', 75),
      new OrdinalSales('Mei', 45),
      new OrdinalSales('Juni', 35),
      new OrdinalSales('Juli', 67),
      new OrdinalSales('Agustus', 98),
      new OrdinalSales('September', 86),
      new OrdinalSales('Oktober', 55),
      new OrdinalSales('November', 25),
      new OrdinalSales('Desember', 100),
    ];

    // final tableSalesData = [
    //   new OrdinalSales('Januari', 25),
    //   new OrdinalSales('Februari', 50),
    //   new OrdinalSales('Maret', 10),
    //   new OrdinalSales('April', 20),
    // ];

    // final mobileSalesData = [
    //   new OrdinalSales('Januari', 10),
    //   new OrdinalSales('Februari', 15),
    //   new OrdinalSales('Maret', 50),
    //   new OrdinalSales('April', 45),
    // ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      // new charts.Series<OrdinalSales, String>(
      //   id: 'Tablet',
      //   domainFn: (OrdinalSales sales, _) => sales.year,
      //   measureFn: (OrdinalSales sales, _) => sales.sales,
      //   data: tableSalesData,
      // ),
      // new charts.Series<OrdinalSales, String>(
      //   id: 'Mobile',
      //   domainFn: (OrdinalSales sales, _) => sales.year,
      //   measureFn: (OrdinalSales sales, _) => sales.sales,
      //   data: mobileSalesData,
      // ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
