import 'package:archonit_task_2025_09_02/app.dart';
import 'package:archonit_task_2025_09_02/core/env/coin_cap_env.dart';
import 'package:archonit_task_2025_09_02/core/services/dio_client.dart';
import 'package:archonit_task_2025_09_02/data/repositories/coin_cap_repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final coinCapDioClient = DioClient(
    baseUrl: CoinCapEnv.apiUrl,
    apiKey: CoinCapEnv.apiKey,
  );

  final coinCapRepo = CoinCapRepo(coinCapDioClient);

  Intl.defaultLocale = 'en_US';

  runApp(
    CoinCapProvider(
      coinCapRepo: coinCapRepo,
      child: const App(),
    ),
  );
}

class CoinCapProvider extends InheritedWidget {
  final CoinCapRepo coinCapRepo;

  const CoinCapProvider({
    super.key,
    required this.coinCapRepo,
    required super.child,
  });

  static CoinCapRepo of(BuildContext context) {
    final CoinCapProvider? result = context
        .dependOnInheritedWidgetOfExactType<CoinCapProvider>();
    assert(result != null, 'No CoinCapProvider found in context');
    return result!.coinCapRepo;
  }

  @override
  bool updateShouldNotify(CoinCapProvider oldWidget) =>
      coinCapRepo != oldWidget.coinCapRepo;
}
