import 'package:candlestick_implementation/model/crypto_asset_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier.dart';
import 'charts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CryptoAssetsData _cryptoAssetsData;
  @override
  void initState() {
    super.initState();
    //fetch and parse json data from file
    _fetchData();
  }

  Future<void> _fetchData() async {
    _cryptoAssetsData =
        await context.read<AppNotifier>().readJsonData('24_hour_interval.json');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // CryptoAssetsData _cryptoAssetsData =
    //     context.watch<AppNotifier>().cryptoAssetsData;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            elevation: 0,
            leading: Icon(Icons.person_rounded),
            title: RichText(
              text: TextSpan(
                  text: 'Binance ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                        text: 'Lite',
                        style: TextStyle(
                          color: Colors.orange[500],
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),
                  ]),
            ),
            centerTitle: true,
            actions: [
              Icon(Icons.search),
              SizedBox(width: 10),
              Icon(Icons.scanner),
              SizedBox(width: 10)
            ],
          ),
          body: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Markets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text('All'),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Icon(
                          Icons.star,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 14,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text('Market Cap'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_cryptoAssetsData != null)
                    Column(
                      children:
                          _cryptoAssetsData.data.asMap().entries.map((entry) {
                        var e = entry.value;
                        return DashboardTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CandleChart(
                                        data: entry.value, index: entry.key)));
                          },
                          percentageColor:
                              e.open > e.close ? Colors.red : Colors.green,
                          currentPrice: e.price.toString(),
                          title: e.symbol,
                          subtitle: e.name,
                          image: handleImageAsset(e.symbol),
                          percentage: e.percentChange24H.toString(),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          )),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title, subtitle, trailing, image, currentPrice, percentage;

  final Color percentageColor;

  final VoidCallback onTap;

  DashboardTile(
      {@required this.onTap,
      @required this.percentageColor,
      @required this.currentPrice,
      @required this.percentage,
      @required this.title,
      @required this.subtitle,
      this.trailing,
      @required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  height: 30,
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: Colors.white)),
                    SizedBox(height: 5.0),
                    Text(subtitle,
                        style: TextStyle(color: Colors.white.withOpacity(0.5))),
                  ],
                ),
              ],
            ),
            //Image.asset(trailing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$$currentPrice', style: TextStyle(color: Colors.white)),
                Text(
                    percentageColor == Colors.green
                        ? '+$percentage%'
                        : '$percentage%',
                    style: TextStyle(color: percentageColor)),
                SizedBox(height: 2.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String handleImageAsset(String name) {
  switch (name) {
    case 'BTC':
      return 'assets/images/btc_ic.png';
    case 'LTC':
      return 'assets/images/litecoin.png';
      break;
    default:
      return 'assets/images/btc_ic.png';
  }
}
