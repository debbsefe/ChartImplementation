import 'dart:convert';

CryptoAssetsData cryptoAssetsDataFromJson(String str) =>
    CryptoAssetsData.fromJson(json.decode(str));

String cryptoAssetsDataToJson(CryptoAssetsData data) =>
    json.encode(data.toJson());

class CryptoAssetsData {
  CryptoAssetsData({
    this.config,
    this.data,
  });

  Config? config;
  List<Datum>? data;

  factory CryptoAssetsData.fromJson(Map<String, dynamic> json) =>
      CryptoAssetsData(
        config: Config.fromJson(json['config']),
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'config': config!.toJson(),
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Config {
  Config({
    this.data,
    this.configDataPoints,
    this.interval,
    this.symbol,
    this.timeSeriesIndicators,
    this.dataPoints,
  });

  String? data;
  String? configDataPoints;
  String? interval;
  String? symbol;
  String? timeSeriesIndicators;
  int? dataPoints;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        data: json['data'],
        configDataPoints: json['data_points\t'],
        interval: json['interval'],
        symbol: json['symbol'],
        timeSeriesIndicators: json['time_series_indicators'],
        dataPoints: json['data_points'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'data_points\t': configDataPoints,
        'interval': interval,
        'symbol': symbol,
        'time_series_indicators': timeSeriesIndicators,
        'data_points': dataPoints,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.symbol,
    this.price,
    this.priceBtc,
    this.marketCap,
    this.percentChange24H,
    this.percentChange7D,
    this.percentChange30D,
    this.volume24H,
    this.maxSupply,
    this.timeSeries,
    this.time,
    this.open,
    this.high,
    this.low,
    this.volume,
    this.close,
  });

  int? id;
  String? name;
  String? symbol;
  double? price;
  double? priceBtc;
  int? marketCap;
  double? percentChange24H;
  double? percentChange7D;
  double? percentChange30D;
  double? volume24H;
  String? maxSupply;
  List<TimeSeries>? timeSeries;

  int? time;
  double? open;
  double? high;
  double? low;
  int? volume;

  double? close;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        price: json['price'].toDouble(),
        priceBtc: json['price_btc'].toDouble(),
        marketCap: json['market_cap'],
        percentChange24H: json['percent_change_24h'].toDouble(),
        percentChange7D: json['percent_change_7d'].toDouble(),
        percentChange30D: json['percent_change_30d'].toDouble(),
        volume24H: json['volume_24h'].toDouble(),
        maxSupply: json['max_supply'],
        timeSeries: List<TimeSeries>.from(
            json['timeSeries'].map((x) => TimeSeries.fromJson(x))),
        time: json['time'],
        open: json['open'].toDouble(),
        high: json['high'].toDouble(),
        low: json['low'].toDouble(),
        volume: json['volume'],
        close: json['close'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'price': price,
        'price_btc': priceBtc,
        'market_cap': marketCap,
        'percent_change_24h': percentChange24H,
        'percent_change_7d': percentChange7D,
        'percent_change_30d': percentChange30D,
        'volume_24h': volume24H,
        'max_supply': maxSupply,
        'timeSeries': List<dynamic>.from(timeSeries!.map((x) => x.toJson())),
        'time': time,
        'open': open,
        'high': high,
        'low': low,
        'volume': volume,
        'close': close,
      };
}

class TimeSeries {
  TimeSeries({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.time,
  });

  double? open;
  double? high;
  double? low;
  double? close;
  int? volume;
  int? time;

  factory TimeSeries.fromJson(Map<String, dynamic> json) => TimeSeries(
        open: json['open'].toDouble(),
        high: json['high'].toDouble(),
        low: json['low'].toDouble(),
        close: json['close'].toDouble(),
        volume: json['volume'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'open': open,
        'high': high,
        'low': low,
        'close': close,
        'volume': volume,
        'time': time,
      };
}
