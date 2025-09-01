import 'package:archonit_task_2025_09_02/data/models/asset.dart';

abstract class DataSource {
  const DataSource();

  Future<Result<List<Asset>>> getAssets([
    GetAssetParams? params,
  ]);
}

class GetAssetParams {
  /// asset slug (bitcoin) or symbol (BTC)
  final String? search;

  /// e.g. bitcoin,ethereum
  final List<String>? ids;

  /// Number of results to return (default is 100)
  final int? limit;

  /// Number of results to skip (default is 0)
  final int? offset;

  const GetAssetParams({
    this.search,
    this.ids,
    this.limit,
    this.offset,
  });

  /// Whether any parameter is set
  bool get canUse =>
      search != null || ids != null || limit != null || offset != null;

  Map<String, dynamic>? buildQueryParams() {
    final json = {
      if (search != null) 'search': search,
      if (ids != null) 'ids': ids!.join(','),
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
    };

    return json.isEmpty ? null : json;
  }

  GetAssetParams copyWith({
    String? search,
    List<String>? ids,
    int? limit,
    int? offset,
  }) {
    return GetAssetParams(
      search: search ?? this.search,
      ids: ids ?? this.ids,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}

sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  final T data;

  const Ok(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});
}
