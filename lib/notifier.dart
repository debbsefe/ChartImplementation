import 'package:flutter/material.dart';

import 'json_reader.dart';
import 'model/crypto_asset_model.dart';

class AppNotifier extends ChangeNotifier {
  CryptoAssetsData _cryptoAssetsData;
  CryptoAssetsData get cryptoAssetsData => _cryptoAssetsData;

  double _percentChange;

  Color _isGain;

  double get percentChange => _percentChange;
  Color get isGain => _isGain;

  void getPercentage({double open, double close}) {
    _percentChange = null;

    _percentChange = ((close - open) / open) * 100;
    _isGain = close > open ? Colors.green : Colors.red;
    notifyListeners();
  }

  Future<CryptoAssetsData> readJsonData(String filename) async {
    _cryptoAssetsData = null;
    final CryptoAssetsData cryptoAssetsData = await readJson(filename);

    _cryptoAssetsData = cryptoAssetsData;
    notifyListeners();
    return cryptoAssetsData;
  }
}
