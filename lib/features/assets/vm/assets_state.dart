import 'dart:collection';

import 'package:archonit_task_2025_09_02/features/assets/vm/asset_entity.dart';

sealed class AssetState {
  const AssetState();
}

class AssetStateInitial extends AssetState {
  const AssetStateInitial();
}

class AssetStateLoading extends AssetState {
  const AssetStateLoading();
}

class AssetStateLoaded extends AssetState {
  final List<AssetEntity> _assets;
  const AssetStateLoaded(this._assets);

  UnmodifiableListView<AssetEntity> get assets => UnmodifiableListView(_assets);
}

class AssetStateError extends AssetState {
  const AssetStateError(this.message);

  final String message;
}
