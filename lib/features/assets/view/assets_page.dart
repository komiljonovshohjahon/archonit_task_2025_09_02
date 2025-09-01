import 'dart:collection';

import 'package:archonit_task_2025_09_02/data/repositories/coin_cap_repo.dart';
import 'package:archonit_task_2025_09_02/features/assets/vm/asset_entity.dart';
import 'package:archonit_task_2025_09_02/features/assets/vm/assets_state.dart';
import 'package:archonit_task_2025_09_02/features/assets/vm/assets_vm.dart';
import 'package:archonit_task_2025_09_02/utils/sizes.dart';
import 'package:flutter/material.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage(this._coinCapRepo, {super.key});

  final CoinCapRepo _coinCapRepo;

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late final AssetsVm vm;

  final _scrollController = ScrollController();

  @override
  void initState() {
    vm = AssetsVm(widget._coinCapRepo);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //handle scroll controller notification after the UI is built because vm needs to be fully initialized
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    //loading more when it reaches 1 tile before the bottom
    final isAtBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - Sizes.tileItemHeight;

    if (isAtBottom) {
      if (vm.isLoadingMore) {
        debugPrint('already loading');
        return;
      }
      if (vm.state is! AssetStateLoaded) {
        debugPrint('not loaded yet');
        return;
      }
      if (!vm.canLoadMore) {
        debugPrint('no more to load');
        return;
      }
      vm.onLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Builder(
              builder: (context) {
                return switch (vm.state) {
                  AssetStateInitial() => Center(
                    child: Text('Welcome to the Assets Page'),
                  ),
                  AssetStateLoading() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  AssetStateError(:final message) => Center(
                    child: Text(message),
                  ),
                  AssetStateLoaded(:final assets) => _Loaded(
                    assets: assets,
                    scrollController: _scrollController,
                  ),
                };
              },
            ),
          ),
        );
      },
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({
    required this.assets,
    required this.scrollController,
  });

  final UnmodifiableListView<AssetEntity> assets;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // this will make sure it loads more when reaching the bottom and stop without bouncing
      physics: const ClampingScrollPhysics(),
      itemExtent: Sizes.tileItemHeight,
      itemCount: assets.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return ListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: asset.color,
            ),
          ),
          title: Text(
            asset.symbol,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          trailing: Text(
            asset.formattedCurrency,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        );
      },
    );
  }
}
