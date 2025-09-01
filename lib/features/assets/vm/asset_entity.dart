import 'package:archonit_task_2025_09_02/data/models/asset.dart';
import 'package:archonit_task_2025_09_02/utils/number_formatter.dart';
import 'package:flutter/rendering.dart';

class AssetEntity {
  final String symbol;
  final double priceUsd;
  final Color color;
  final String formattedCurrency;

  const AssetEntity({
    required this.symbol,
    required this.priceUsd,
    required this.color,
    required this.formattedCurrency,
  });

  /// Initializing view data so that it helps Listview not to generate these again and again when scrolled
  factory AssetEntity.fromAsset(Asset asset) {
    final symbolHash = asset.symbol.hashCode;
    final r = (symbolHash & 0xFF0000) >> 16;
    final g = (symbolHash & 0x00FF00) >> 8;
    final b = (symbolHash & 0x0000FF);
    Color color = Color.fromARGB(255, r, g, b);

    final formattedCurrency = asset.priceUsd.toCurrency();

    return AssetEntity(
      symbol: asset.symbol,
      priceUsd: asset.priceUsd,
      color: color,
      formattedCurrency: formattedCurrency,
    );
  }
}
