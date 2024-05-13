import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:lords_palace_app/screens/archaeologists_room/archaeologists_room_screen.dart';
import 'package:lords_palace_app/screens/home/home_screen.dart';
import 'package:lords_palace_app/screens/loading/loading_screen.dart';
import 'package:lords_palace_app/screens/magic_kitchen/magic_kitchen_screen.dart';
import 'package:lords_palace_app/screens/mysterious_mine/mysterious_mine_screen.dart';
import 'package:lords_palace_app/screens/settings/fortune_game/fortune_game_screen.dart';
import 'package:lords_palace_app/screens/settings/rules/rules_screen.dart';
import 'package:lords_palace_app/screens/settings/settings_list/settings_list_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoadingRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SettingsListRoute.page),
        AutoRoute(page: RulesRoute.page),
        AutoRoute(page: FortuneGameRoute.page),
    AutoRoute(page: MagicKitchenRoute.page),
    AutoRoute(page: MysteriousMineRoute.page),
    AutoRoute(page: ArchaeologistsRoomRoute.page),

  ];
}
