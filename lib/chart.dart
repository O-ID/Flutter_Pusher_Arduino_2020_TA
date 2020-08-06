import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedBarChart extends StatefulWidget {
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
  _StackedBarChartState createState() => _StackedBarChartState();

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('DHT 1', 5),
      new OrdinalSales('DHT 3', 25),
      new OrdinalSales('DHT 4', 20),
      new OrdinalSales('DHT 5', 75),
      new OrdinalSales('DHT 6', 45),
      new OrdinalSales('Air', 67),
    ];
    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData,
          labelAccessorFn: (OrdinalSales row, _) => row.sales.toString(),
          colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault),
    ];
  }
}

class _StackedBarChartState extends State<StackedBarChart> {
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      widget.seriesList,
      animate: widget.animate,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
