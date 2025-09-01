import 'package:archonit_task_2025_09_02/features/assets/view/assets_page.dart';
import 'package:archonit_task_2025_09_02/main.dart';
import 'package:flutter/material.dart';

final _lightTheme = ThemeData.light();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archonit Task',
      initialRoute: "/",
      theme: _lightTheme.copyWith(
        textTheme: _lightTheme.textTheme.apply(
          fontFamily: 'SFProText',
        ),
        colorScheme: ColorScheme.light(
          onSurface: const Color(0xFF17171A),
          surface: const Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      routes: {
        "/": (context) {
          final repo = CoinCapProvider.of(context);
          return AssetsPage(repo);
        },
      },
    );
  }
}
