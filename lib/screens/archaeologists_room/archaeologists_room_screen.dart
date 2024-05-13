import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/router/router.dart';
import 'package:lords_palace_app/theme/colors.dart';
import 'package:lords_palace_app/widgets/action_button_widget.dart';
import 'package:lords_palace_app/widgets/coins/coins_bloc/coins_bloc.dart';

@RoutePage()
class ArchaeologistsRoomScreen extends StatefulWidget {
  const ArchaeologistsRoomScreen({super.key});

  @override
  State<ArchaeologistsRoomScreen> createState() => _ArchaeologistsRoomScreenState();
}

class _ArchaeologistsRoomScreenState extends State<ArchaeologistsRoomScreen> {
  int startGameTime = DateTime.now().millisecondsSinceEpoch;
  bool isGameOver = false;

  List<int> gridItems = List.generate(25, (index) => Random().nextInt(10) + 1);
  int matches = 0;
  bool spinning = false;
  int spinCount = 0;
  late Timer timer;

  int coins = 0;

  void spinGrid() {
    if (!spinning) {
      setState(() {
        spinning = true;
        spinCount = 0;
      });

      Timer.periodic(Duration(milliseconds: 100), (t) {
        setState(() {
          gridItems = List.generate(25, (index) => Random().nextInt(10) + 1);
        });
        spinCount++;
        if (spinCount == 40) {
          t.cancel();
          setState(() {
            spinning = false;
            checkForMatches();
          });
        }
      });
    }
  }

  void checkForMatches() {
    for (int i = 0; i <= 22; i++) {
      if (gridItems[i] == gridItems[i + 1] &&
          gridItems[i] == gridItems[i + 2]) {
        setState(() {
          matches++;
          coins += 50;
        });
      }
    }
    if (matches >= 10) {
      isGameOver = true;
      _winDialog();
    }
  }

  int endTime() {
    final int levelCountdownTimer = 5 * 60 * 1000 + 0 * 1000;
    final int timeLeft = levelCountdownTimer -
        (DateTime.now().millisecondsSinceEpoch - startGameTime);
    return DateTime.now().millisecondsSinceEpoch + timeLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/archaeologists/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isGameOver = true;
                        context.router.push(HomeRoute());
                      },
                      child: SvgPicture.asset(
                          'assets/images/elements/back-btn.svg'),
                    ),
                    Image.asset('assets/images/archaeologists/title.png'),
                    SizedBox(width: 70),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                      decoration: BoxDecoration(
                          color: AppColors.darkPurple,
                          borderRadius:
                          BorderRadius.all(Radius.circular(100.0))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/elements/coin.svg'),
                          SizedBox(width: 5),
                          Text(
                            '$coins',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                      decoration: BoxDecoration(
                          color: AppColors.darkPurple,
                          borderRadius:
                          BorderRadius.all(Radius.circular(100.0))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/elements/timer.svg'),
                          SizedBox(width: 5),
                          Center(
                            child: CountdownTimer(
                              textStyle: TextStyle(
                                decoration: TextDecoration.none,
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              endTime: endTime(),
                              onEnd: () {
                                if (isGameOver == false) {
                                  _loseDialog();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                      decoration: BoxDecoration(
                          color: AppColors.darkPurple,
                          borderRadius:
                          BorderRadius.all(Radius.circular(100.0))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/elements/pairs.svg'),
                          SizedBox(width: 5),
                          Text(
                            '$matches / 10',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Image.asset('assets/images/archaeologists/avatar.png'),
                SizedBox(
                  width: 190,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/archaeologists/bottom-tile.svg'),
                      Text(
                        'Press Spin to Start',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 350,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                          'assets/images/archaeologists/board/board.png'),
                      SizedBox(
                        width: 335,
                        height: 335,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                          ),
                          itemCount: gridItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Image.asset(
                                    'assets/images/archaeologists/board/${gridItems[index]}.png'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ActionButtonWidget(text: 'Spin', onTap: spinGrid)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loseDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/archaeologists/avatar.png'),
              SizedBox(
                width: 190,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                        'assets/images/archaeologists/bottom-tile.svg'),
                    Text(
                      'Try Again!',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Color(0xFF4D23AB)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Game Over',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                            decoration: BoxDecoration(
                                color: AppColors.darkPurple,
                                borderRadius:
                                BorderRadius.all(Radius.circular(100.0))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/elements/pairs.svg'),
                                SizedBox(width: 5),
                                Text(
                                  '$matches / 10',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          ActionButtonWidget(
                              text: 'Try Again',
                              onTap: () {
                                context
                                    .read<CoinsBloc>()
                                    .add(AddCoinsEvent(value: coins));
                                context.router.push(ArchaeologistsRoomRoute());
                              }),
                          SizedBox(height: 15),
                          ActionButtonWidget(
                              text: 'Lobby',
                              onTap: () {
                                context
                                    .read<CoinsBloc>()
                                    .add(AddCoinsEvent(value: coins));
                                context.router.push(HomeRoute());
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _winDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/archaeologists/avatar.png'),
              SizedBox(
                width: 190,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                        'assets/images/archaeologists/bottom-tile.svg'),
                    Text(
                      'Congratulations!',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Color(0xFFFFC700), width: 5),
                      color: Color(0xFF4D23AB)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Big Win!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white),
                          ),
                          SizedBox(height: 25),
                          Container(
                            padding: EdgeInsets.fromLTRB(3, 3, 10, 3),
                            decoration: BoxDecoration(
                                color: AppColors.darkPurple,
                                borderRadius:
                                BorderRadius.all(Radius.circular(100.0))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/elements/pairs.svg'),
                                SizedBox(width: 5),
                                Text(
                                  '$matches / 10',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                  'assets/images/elements/coin.svg'),
                              SizedBox(width: 5),
                              Text(
                                '+500',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          ActionButtonWidget(
                              text: 'Lobby',
                              onTap: () {
                                context
                                    .read<CoinsBloc>()
                                    .add(AddCoinsEvent(value: coins + 500));
                                context.router.push(HomeRoute());
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
