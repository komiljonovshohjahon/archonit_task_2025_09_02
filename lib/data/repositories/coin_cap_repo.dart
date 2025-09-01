import 'package:archonit_task_2025_09_02/core/services/data_source.dart';
import 'package:archonit_task_2025_09_02/core/services/dio_client.dart';
import 'package:archonit_task_2025_09_02/data/models/asset.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CoinCapRepo extends DataSource {
  final DioClient _client;

  const CoinCapRepo(this._client);

  @override
  Future<Result<List<Asset>>> getAssets([GetAssetParams? params]) async {
    try {
      final Map<String, dynamic>? queryParams = params?.buildQueryParams();

      debugPrint('queryParams: $queryParams');

      final Response response = await _client.dio.get(
        '/assets',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final list = <Asset>[];
        for (var item in response.data['data']) {
          list.add(Asset.fromJson(item));
        }
        return Ok(list);
      }
      return Failure("Failed to get assets: ${response.statusMessage}");
    } catch (e) {
      return Failure("Failed to get assets: $e");
    }
  }
}
