import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/router/router.dart';
import 'package:lords_palace_app/screens/settings/fortune_game/fortune_game_bloc/fortune_game_bloc.dart';
import 'package:lords_palace_app/theme/colors.dart';
import 'package:lords_palace_app/widgets/action_button_widget.dart';
import 'package:lords_palace_app/widgets/coins/coins.dart';

@RoutePage()
class FortuneGameScreen extends StatefulWidget {
  const FortuneGameScreen({super.key});

  @override
  State<FortuneGameScreen> createState() => _FortuneGameScreenState();
}

class _FortuneGameScreenState extends State<FortuneGameScreen> {
  StreamController<int> controller = StreamController<int>();

  int resultIndex = 0;
  final List<String> items = [
    'Try Again',
    '50',
    'Try Again',
    '100',
    'Try Again',
    '150',
    'Try Again',
    '200',
    'Try Again',
    '250',
    'Try Again',
    '300'
  ];

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home/home-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.router.push(SettingsListRoute());
                      },
                      child: SvgPicture.asset(
                          'assets/images/elements/back-btn.svg'),
                    ),
                    Image.asset('assets/images/settings/fortune-title.png'),
                    CoinsWidget(),
                  ],
                ),
                Container(
                  width: 340,
                  height: 340,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/fortune/wheel-stroke.png'),
                      SizedBox(
                        width: 290,
                        height: 290,
                        child: FortuneWheel(
                          physics: NoPanPhysics(),
                          animateFirst: false,
                          selected: controller.stream,
                          items: [
                            for (var item in items)
                              FortuneItem(
                                child: item == 'Try Again'
                                    ? Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white),
                                      )
                                    : Row(
                                        children: [
                                          SizedBox(width: 60),
                                          SvgPicture.asset(
                                              'assets/images/elements/coin.svg'),
                                          SizedBox(width: 5),
                                          Text(
                                            item,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white),
                                          ),
                                        ],
                                      ),
                                style: FortuneItemStyle(
                                  color: item == 'Try Again'
                                      ? Color(0xFFFC19F5)
                                      : Color(0xFF401E8C),
                                ),
                              ),
                          ],
                          indicators: <FortuneIndicator>[
                            FortuneIndicator(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  'assets/images/fortune/indicator.png'),
                            ),
                          ],
                          onAnimationEnd: () {
                            if (items[resultIndex] == 'Try Again') {
                              _loseDialog();
                            } else {
                              _winDialog();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      FortuneGameBloc()..add(CheckFortuneGameEvent()),
                  child: BlocBuilder<FortuneGameBloc, FortuneGameState>(
                    builder: (context, state) {
                      if (state is SuccessFortuneGameState) {
                        return ActionButtonWidget(
                            text: 'SPIN',
                            onTap: () {
                              resultIndex = Fortune.randomInt(0, items.length);
                              controller.add(resultIndex);
                            });
                      } else if (state is FailureFortuneGameState) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/images/fortune/timer-bg.svg'),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Next Spin in ',
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  CountdownTimer(
                                    textStyle: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    endTime:
                                        DateTime.now().millisecondsSinceEpoch +
                                            state.timeLeft,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _winDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: 250,
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(color: Color(0xFFFFC700), width: 5),
                  color: Color(0xFF1A0C39)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'You Won!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                      SizedBox(height: 25),
                      SvgPicture.asset('assets/images/elements/coin.svg'),
                      SizedBox(height: 5),
                      Text(
                        items[resultIndex],
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      SizedBox(height: 25),
                      ActionButtonWidget(
                          text: 'OK',
                          onTap: () {
                            context.read<FortuneGameBloc>().add(
                                GetFortuneCoinsEvent(
                                    coins: int.parse(items[resultIndex])));
                            context.router.push(HomeRoute());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _loseDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: 250,
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(color: Color(0xFF5B3BA1), width: 5),
                  color: Color(0xFF1A0C39)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Better Luck in Next Time...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                      SizedBox(height: 25),
                      ActionButtonWidget(
                          text: 'OK',
                          onTap: () {
                            context
                                .read<FortuneGameBloc>()
                                .add(GetFortuneCoinsEvent(coins: 0));
                            context.router.push(HomeRoute());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
