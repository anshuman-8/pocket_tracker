// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PieChart extends StatefulWidget {
//   const PieChart({Key? key}) : super(key: key);

//   @override
//   State<PieChart> createState() => _PieChartState();
// }

// class _PieChartState extends State<PieChart> {
//   List<_SalesData> chartData = [
//     _SalesData('Jan', 2000),
//     _SalesData('Feb', 3300),
//     _SalesData('Mar', 2300),
//     _SalesData('Apr', 1500),
//     _SalesData('May', 1200)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Container(
//       height: 500,
//       width: 320,
//       //Initialize the chart widget
//       child: SfCircularChart(
//           // backgroundColor: Colors.white,
//           onDataLabelRender: (DataLabelRenderArgs args) {
//             double value = double.parse(args.text);
//             args.text = value.toStringAsFixed(0);
//           },
//           series: <CircularSeries<_SalesData, String>>[
//             PieSeries<_SalesData, String>(
//                 selectionBehavior: SelectionBehavior(enable: true),
//                 explode: true,
//                 dataSource: chartData,
//                 xValueMapper: (_SalesData sales, _) => sales.year,
//                 yValueMapper: (_SalesData sales, _) => sales.sales,
//                 name: 'Sales',
//                 dataLabelSettings: DataLabelSettings(
//                   isVisible: true,
//                 ))
//           ]),
//     ));
//   }
// }

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }
