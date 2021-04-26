import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/crypto_asset_model.dart';

Future<CryptoAssetsData> readJson(String name) async {
  final String response = await rootBundle.loadString('lib/data/$name');
  final data = json.decode(response);
  final result = CryptoAssetsData.fromJson(data);
  return result;
}
