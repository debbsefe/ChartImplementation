import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifier.dart';
import '../size_ext.dart';
import '../model/crypto_asset_model.dart';

class CandleChart extends StatefulWidget {
  final Datum data;
  final int index;

  const CandleChart({Key key, this.data, this.index}) : super(key: key);

  @override
  _CandleChartState createState() => _CandleChartState();
}

class _CandleChartState extends State<CandleChart> {
  static const List<String> list = [
    "1D",
    "1M",
    "3M",
    "6M",
    "1Y",
  ];
  int index = 0;
  bool isLine = true;
  bool callNotifier = false;
  @override
  Widget build(BuildContext context) {
    Color isGain =
        widget.data.open > widget.data.close ? Colors.red : Colors.green;
    double percentChange = context.watch<AppNotifier>().percentChange;
    Color gain = context.watch<AppNotifier>().isGain;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(widget.data.name),
          centerTitle: true,
          elevation: 0,
          actions: [
            Icon(Icons.star),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '\$${widget.data.price.toString()}',
                        style: TextStyle(fontSize: 32),
                      ),
                      Icon(
                        Icons.info,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        callNotifier && gain == Colors.red
                            ? '${percentChange.toStringAsFixed(2)} %'
                            : callNotifier && gain == Colors.green
                                ? '+${percentChange.toStringAsFixed(2)} %'
                                : isGain == Colors.green
                                    ? '+${widget.data.percentChange24H.toString()} %'
                                    : '${widget.data.percentChange24H.toString()} %',
                        style: TextStyle(
                          fontSize: 16,
                          color: callNotifier
                              ? gain
                              : widget.data.open > widget.data.close
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                      Icon(
                          gain == Colors.green || isGain == Colors.green
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          size: 14,
                          color: callNotifier ? gain : isGain),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isLine = true;
                          setState(() {});
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isLine ? Colors.grey : Colors.transparent,
                            ),
                            child: Text('Line Chart')),
                      ),
                      GestureDetector(
                        onTap: () {
                          isLine = false;
                          setState(() {});
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isLine ? Colors.transparent : Colors.grey,
                            ),
                            child: Text('Candle Chart')),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: context.height(0.4),
                    width: double.infinity,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: isLine
                          ? CryptoChartPainter(
                              callNotifier: callNotifier,
                              gain: gain,
                              isGain: isGain,
                              timeSeries: callNotifier
                                  ? context
                                      .watch<AppNotifier>()
                                      .cryptoAssetsData
                                      .data[widget.index]
                                      .timeSeries
                                  : widget.data.timeSeries)
                          : CryptoCandlePainter(
                              timeSeries: callNotifier
                                  ? context
                                      .watch<AppNotifier>()
                                      .cryptoAssetsData
                                      .data[widget.index]
                                      .timeSeries
                                  : widget.data.timeSeries),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: list.asMap().entries.map((entry) {
                      var e = entry.value;
                      return GestureDetector(
                        onTap: () async {
                          index = entry.key;
                          callNotifier = true;

                          CryptoAssetsData cryptoAssetsData = await context
                              .read<AppNotifier>()
                              .readJsonData(handleDateRange(e));

                          //the first open value in a timeseries
                          double cryptoOpen = cryptoAssetsData
                              .data[widget.index].timeSeries.first.open;
                          //the last close value in a timeseries
                          double cryptoClose = cryptoAssetsData
                              .data[widget.index].timeSeries.last.close;

                          context.read<AppNotifier>().getPercentage(
                              open: cryptoOpen, close: cryptoClose);

                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeInOut,
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                              color: entry.key == index
                                  ? Colors.grey
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text(
                            e,
                            style: TextStyle(
                              color: entry.key == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String handleDateRange(String date) {
  switch (date) {
    case '1D':
      return '24_hour_interval.json';
    case '1M':
      return 'one_month_interval.json';
    case '3M':
      return 'three_month_interval.json';
    case '6M':
      return 'six_month_interval.json';
    case '1Y':
      return 'one_year_interval.json';
      break;
    default:
      return 'assets/images/btc_ic.png';
  }
}

class CryptoChartPainter extends CustomPainter {
  final List<TimeSery> timeSeries;
  final Color isGain;
  final Paint _paint;
  final Color gain;
  final bool callNotifier;
  final double strokeWidth;

  CryptoChartPainter(
      {@required this.timeSeries,
      @required this.isGain,
      @required this.gain,
      this.strokeWidth,
      @required this.callNotifier})
      : _paint = Paint()
          ..color = callNotifier ? gain : isGain
          ..strokeWidth = strokeWidth ?? 2;
  @override
  void paint(Canvas canvas, Size size) {
    if (timeSeries == null) {
      return;
    }

    List<LineChart> charts = _generateChart(size);
    charts.asMap().entries.map((e) {
      LineChart chart = e.value;
      int currentIndex = e.key;

      Offset p1 = Offset(
        chart.centerX1,

        //normalize the y1 so that the lines join properly
        currentIndex == 0
            ? (size.height - chart.centerY1)
            : (size.height - charts[currentIndex - 1].centerY2),
      );
      Offset p2 = Offset(
        chart.centerX2,
        size.height - chart.centerY2,
      );

      return canvas.drawLine(p1, p2, _paint);
    }).toList();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  List<LineChart> _generateChart(Size availableSpace) {
    //the greatest high in a timeseries
    TimeSery cryptoHigh = timeSeries.reduce((a, b) => a.high > b.high ? a : b);
    //the lowest low in a timeseries
    TimeSery cryptoLow = timeSeries.reduce((a, b) => a.low < b.low ? a : b);

    //normalize available width space using the length of the timeseries
    double pixelPerStick = availableSpace.width / (timeSeries.length + 1);

    //normalize available height space using crypto high and low

    double pixelPerPrice =
        availableSpace.height / (cryptoHigh.high - cryptoLow.low);

    final List<LineChart> lineChart = [];
    for (int i = 0; i < timeSeries.length; ++i) {
      final TimeSery series = timeSeries[i];
      lineChart.add(LineChart(
        centerX1: (i + 1) * pixelPerStick,
        centerX2: (i + 2) * pixelPerStick,
        centerY1: (series.open - cryptoLow.low) * pixelPerPrice,
        centerY2: (series.close - cryptoLow.low) * pixelPerPrice,
      ));
    }
    return lineChart;
  }
}

class LineChart {
  final double centerX1;
  final double centerX2;
  final double centerY1;
  final double centerY2;

  LineChart({
    @required this.centerX1,
    @required this.centerX2,
    @required this.centerY1,
    @required this.centerY2,
  });
}

class CryptoCandlePainter extends CustomPainter {
  final List<TimeSery> timeSeries;
  final double _candleWidth = 3.0;
  final double _wickWidth = 1.0;
  final Paint _lossPaint;
  final Paint _gainPaint;
  final Paint _wickPaint;

  CryptoCandlePainter({@required this.timeSeries})
      : _gainPaint = Paint()..color = Colors.green,
        _lossPaint = Paint()..color = Colors.red,
        _wickPaint = Paint()..color = Colors.grey;
  @override
  void paint(Canvas canvas, Size size) {
    if (timeSeries == null) {
      return;
    }
    List<CandleStick> candleSticks = _generateSticks(size);

    for (CandleStick candleStick in candleSticks) {
      canvas.drawRect(
        Rect.fromLTRB(
          candleStick.center - (_wickWidth / 2),
          size.height - candleStick.wickHigh,
          candleStick.center + (_wickWidth / 2),
          size.height - candleStick.wickLow,
        ),
        _wickPaint,
      );

      canvas.drawRect(
        Rect.fromLTRB(
          candleStick.center - (_candleWidth / 2),
          size.height - candleStick.candleHigh,
          candleStick.center + (_candleWidth / 2),
          size.height - candleStick.candleLow,
        ),
        candleStick.candlePaint,
      );
    }
  }

  List<CandleStick> _generateSticks(Size availableSpace) {
    //the greatest high in a timeseries
    TimeSery cryptoHigh = timeSeries.reduce((a, b) => a.high > b.high ? a : b);
    //the lowest low in a timeseries
    TimeSery cryptoLow = timeSeries.reduce((a, b) => a.low < b.low ? a : b);

    double pixelPerStick = availableSpace.width / (timeSeries.length + 1);

    double pixelPerPrice =
        availableSpace.height / (cryptoHigh.high - cryptoLow.low);

    final List<CandleStick> candleSticks = [];
    for (int i = 0; i < timeSeries.length; ++i) {
      final TimeSery series = timeSeries[i];
      candleSticks.add(
        CandleStick(
            candleHigh: (series.open - cryptoLow.low) * pixelPerPrice,
            candleLow: (series.close - cryptoLow.low) * pixelPerPrice,
            candlePaint: series.open > series.close ? _lossPaint : _gainPaint,
            center: (i + 1) * pixelPerStick,
            wickHigh: (series.high - cryptoLow.low) * pixelPerPrice,
            wickLow: (series.low - cryptoLow.low) * pixelPerPrice),
      );
    }
    return candleSticks;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CandleStick {
  final double wickHigh;
  final double wickLow;
  final double candleHigh;
  final double candleLow;
  final double center;
  final Paint candlePaint;

  CandleStick(
      {@required this.center,
      @required this.candlePaint,
      @required this.wickHigh,
      @required this.wickLow,
      @required this.candleHigh,
      @required this.candleLow});
}
