import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';

List<Map> sampleData = [
  {
    "time": DateTime(2021, 9, 1),
    "value": 10,
  },
  {
    "time": DateTime(2021, 9, 2),
    "value": 20,
  },
  {
    "time": DateTime(2021, 9, 3),
    "value": 13,
  },
  {
    "time": DateTime(2021, 9, 4),
    "value": 2,
  },
  {
    "time": DateTime(2021, 9, 5),
    "value": 10,
  },
  {
    "time": DateTime(2021, 9, 6),
    "value": 23,
  },
];

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
// 最初に一度だけ実行される初期化処理
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ステータスバーを透明にする
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    final double deviceWidth = MediaQuery.of(context).size.width; // デバイスの幅
    final double deviceHeight = MediaQuery.of(context).size.height; // デバイスの高さ
    final double topPadding = MediaQuery.of(context).padding.top; // 上の余白

    return Scaffold(
      backgroundColor: Color(0xFFF9EA85),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                "441-8580, Tempakucho, Toyohashi, Japan",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Available Sunshine",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[600],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        decoration: ShapeDecoration(
                          color: Colors.orange[600],
                          shape: StadiumBorder(),
                        ),
                        height: 9,
                        width: 85,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Ways to Save Energy",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Solar Irradiance",
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.grey[400],
                    size: 24,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              padding: EdgeInsets.all(10),
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: chartBody(sampleData),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PAR",
                    style: GoogleFonts.montserrat(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.grey[400],
                    size: 24,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              padding: EdgeInsets.all(10),
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: chartBody(sampleData),
            ),
          ],
        ),
      ),
    );
  }

  Widget chartBody(List data) {
    List<DataPoint> dataPointList =
        data.map((element) => DataPoint.fromMap(element)).toList();

    List<charts.Series<DataPoint, DateTime>> seriesList = [
      new charts.Series<DataPoint, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange[300]),
        domainFn: (DataPoint datapoint, _) => datapoint.time,
        measureFn: (DataPoint datapoint, _) => datapoint.value,
        data: dataPointList,
      ),
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),

      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.DateTimeAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 14, // size in Pts.
            color: charts.ColorUtil.fromDartColor(Colors.grey[400]),
          ),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.grey[200]),
          ),
        ),
      ),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 14, // size in Pts.
            color: charts.ColorUtil.fromDartColor(Colors.grey[400]),
          ),

          // Change the line colors to match text color.
          lineStyle: new charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.grey[200]),
          ),
        ),
      ),
    );
  }
}

class DataPoint {
  final int value;
  final DateTime time;
  DataPoint(this.value, this.time);

  DataPoint.fromMap(Map map)
      : assert(map['time'] != null),
        assert(map['value'] != null),
        time = map['time'],
        value = map['value'];

  @override
  String toString() => "Record<$time:$value>";
}
