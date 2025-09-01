import 'package:archonit_task_2025_09_02/core/services/data_source.dart';
import 'package:archonit_task_2025_09_02/data/repositories/coin_cap_repo.dart';
import 'package:archonit_task_2025_09_02/features/assets/vm/asset_entity.dart';
import 'package:archonit_task_2025_09_02/features/assets/vm/assets_state.dart';
import 'package:flutter/material.dart';

class AssetsVm extends ChangeNotifier {
  final CoinCapRepo _repo;

  AssetsVm(this._repo) {
    fetchAssets();
  }

  GetAssetParams _params = GetAssetParams(
    offset: 0,
    limit: 15,
  );

  AssetState _state = const AssetStateInitial();
  AssetState get state => _state;

  Future<void> fetchAssets() async {
    _state = const AssetStateLoading();
    notifyListeners();

    final result = await _repo.getAssets(_params);
    switch (result) {
      case Ok():
        _state = AssetStateLoaded(
          result.data.map(AssetEntity.fromAsset).toList(),
        );
        break;
      case Failure():
        _state = AssetStateError(result.message);
        break;
    }
    notifyListeners();
  }

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  bool _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;

  Future<void> onLoadMore() async {
    _isLoadingMore = true;
    if (_state is! AssetStateLoaded) return;
    final assets = List.of((_state as AssetStateLoaded).assets);
    _params = _params.copyWith(offset: _params.offset! + _params.limit!);
    final result = await _repo.getAssets(_params);
    switch (result) {
      case Ok():
        if (result.data.isEmpty) {
          _canLoadMore = false;
          break;
        }
        final newList = result.data.map(AssetEntity.fromAsset);
        final entites = assets
          ..insertAll(assets.length, newList)
          ..toList();

        _state = AssetStateLoaded(entites);
        break;
      case Failure():
        _state = AssetStateError(result.message);
        break;
    }
    _isLoadingMore = false;
    notifyListeners();
  }
}
