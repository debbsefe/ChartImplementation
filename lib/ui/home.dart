import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/crypto_asset_model.dart';
import '../notifier.dart';
import 'charts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CryptoAssetsData? _cryptoAssetsData;
  @override
  void initState() {
    super.initState();
    //fetch and parse json data from file
    _fetchData();
  }

  Future<void> _fetchData() async {
    _cryptoAssetsData =
        await context.read<AppNotifier>().readJsonData('24_hour_interval.json');
    if (mounted) setState(() {});
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
            leading: const Icon(Icons.person_rounded),
            title: RichText(
              text: TextSpan(
                  text: 'Binance ',
                  style: const TextStyle(
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
            actions: const [
              Icon(Icons.search),
              SizedBox(width: 10),
              Icon(Icons.scanner),
              SizedBox(width: 20)
            ],
          ),
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Markets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text('All'),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Icon(
                          Icons.star,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 14,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text('Market Cap'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  if (_cryptoAssetsData != null)
                    Column(
                      children:
                          _cryptoAssetsData!.data!.asMap().entries.map((entry) {
                        final Datum e = entry.value;

                        return DashboardTile(
                          data: e,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CandleChart(
                                        data: entry.value, index: entry.key)));
                          },
                          percentageColor:
                              e.open! > e.close! ? Colors.red : Colors.green,
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
  final String? title, subtitle, trailing, image, currentPrice, percentage;
  final Datum? data;
  final Color percentageColor;

  final VoidCallback onTap;

  const DashboardTile(
      {required this.onTap,
      required this.percentageColor,
      required this.currentPrice,
      required this.percentage,
      required this.title,
      required this.subtitle,
      this.trailing,
      required this.image,
      this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  image!,
                  height: 30,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title!, style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 5),
                    Text(subtitle!,
                        style: TextStyle(color: Colors.white.withOpacity(0.5))),
                  ],
                ),
              ],
            ),
            SizedBox(
                height: 50,
                width: 100,
                child: CustomPaint(
                    size: const Size.fromWidth(30),
                    painter: CryptoChartPainter(
                        strokeWidth: 1,
                        callNotifier: false,
                        gain: percentageColor,
                        isGain: percentageColor,
                        timeSeries: data!.timeSeries))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$$currentPrice',
                    style: const TextStyle(color: Colors.white)),
                Text(
                    percentageColor == Colors.green
                        ? '+$percentage%'
                        : '$percentage%',
                    style: TextStyle(color: percentageColor)),
                const SizedBox(height: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String handleImageAsset(String? name) {
  switch (name) {
    case 'BTC':
      return 'assets/images/btc.png';
    case 'LTC':
      return 'assets/images/ltc.png';
    case 'XRP':
      return 'assets/images/xrp.png';
    case 'BNB':
      return 'assets/images/bnb.png';
    default:
      return 'assets/images/btc.png';
  }
}
