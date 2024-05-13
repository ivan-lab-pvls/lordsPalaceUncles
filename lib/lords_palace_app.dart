import 'package:flutter/material.dart';
import 'package:lords_palace_app/router/router.dart';

class LordsPalaceApp extends StatelessWidget {
  LordsPalaceApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Rubik'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
