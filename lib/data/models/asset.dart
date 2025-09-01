// "id": "bitcoin",
// "rank": "1",
// "symbol": "BTC",
// "name": "Bitcoin",
// "supply": "19914775.000000000000000000",
// "maxSupply": "21000000.000000000000000000",
// "marketCapUsd": "2166219095794.250000000000000000",
// "volumeUsd24Hr": "22101391823.783657073974609375",
// "priceUsd": "108774.470000000001164153",
// "changePercent24Hr": "-0.31481518308759543",
// "vwap24Hr": "108696.71030405982",
// "explorer": "https://blockchain.info/",
// "tokens": {}

import 'package:flutter/foundation.dart';

class Asset {
  final String id;
  final String symbol;
  final double priceUsd;

  const Asset({
    required this.id,
    required this.symbol,
    required this.priceUsd,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    try {
      return Asset(
        id: json['id'],
        symbol: json['symbol'],
        priceUsd: double.parse(json['priceUsd']),
      );
    } on TypeError catch (e, st) {
      debugPrint("Error parsing Asset: $e");
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }
}
