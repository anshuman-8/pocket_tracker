import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// void main() {
//   return runApp(_ChartApp());
// }

// class ChartApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: _MyHomePage(),
//     );
//   }
// }

class DonutChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  // DonutChart({Key? key}) : super(key: key);

  final Map<String, int> dataList;
  final Map<String, Color> dataColors;

  DonutChart(this.dataList, this.dataColors);

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  Widget build(BuildContext context) {
    // final List<ChartData> chartData = [
    //   ChartData('Grocery', 25, Color.fromRGBO(232, 241, 77, 1)),
    //   ChartData('Medical', 38, Color.fromRGBO(106, 166, 174, 1)),
    //   ChartData('Food', 34, Color.fromRGBO(218, 227, 138, 1)),
    //   ChartData('Fuel', 52, Color.fromRGBO(13, 65, 74, 1)),
    //   ChartData('Others', 52, Color.fromARGB(141, 31, 220, 50)),
    // ];

    final List<ChartData> chartData = [];
    // final List<ChartData> chartData = [
    //   ChartData('Grocery', widget.dataList["Grocery"]!,
    //       Color.fromRGBO(232, 241, 77, 1)),
    //   ChartData('Medical', widget.dataList["Medical"]!,
    //       Color.fromRGBO(106, 166, 174, 1)),
    //   ChartData(
    //       "Food", widget.dataList["Food"]!, Color.fromRGBO(218, 227, 138, 1)),
    //   ChartData(
    //       "Fuel", widget.dataList["Fuel"]!, Color.fromRGBO(13, 65, 74, 1)),
    //   ChartData("Others", widget.dataList["Others"]!,
    //       Color.fromARGB(141, 31, 220, 50)),
    // ];

    for (String key in widget.dataList.keys) {
      chartData
          .add(ChartData(key, widget.dataList[key]!, widget.dataColors[key]));
    }
    return Center(
        child: Stack(children: [
      Container(
          child: SfCircularChart(series: <CircularSeries>[
        // Renders doughnut chart
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          pointColorMapper: (ChartData data, _) => data.color,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          // cornerStyle: CornerStyle.bothCurve,
          radius: '1000%',
          // startAngle: 360,
          // endAngle: 360,
          // pointColorMapper: (ChartData data, _) => data.color,
          // groupMode: CircularChartGroupMode.point,
          // groupTo: 2,
        )
      ])),
      Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
            // 'Total expenditure\n chut',
            // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    ]));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color? color;
}
