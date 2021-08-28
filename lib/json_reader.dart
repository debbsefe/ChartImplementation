import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/crypto_asset_model.dart';

Future<CryptoAssetsData> readJson(String name) async {
  final String response = await rootBundle.loadString('assets/data/$name');
  final result = CryptoAssetsData.fromJson(json.decode(response));
  return result;
}
