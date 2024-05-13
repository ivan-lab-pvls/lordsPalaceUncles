import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lords_palace_app/theme/colors.dart';
import 'package:lords_palace_app/widgets/action_button_widget.dart';
import 'package:lords_palace_app/widgets/daily_reward/daily_reward_bloc/daily_reward_bloc.dart';

class DailyReward extends StatefulWidget {
  const DailyReward({super.key});

  @override
  State<DailyReward> createState() => _DailyRewardState();
}

class _DailyRewardState extends State<DailyReward> {
  List<int> rewards = [0, 50, 100];
  bool _isChosen = false;
  int _indexRandomReward = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 360,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(color: Color(0xFFE946F7), width: 5),
              color: Color(0xFF1A0C39)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocProvider(
                create: (context) =>
                    DailyRewardBloc()..add(CheckDailyRewardEvent()),
                child: BlocBuilder<DailyRewardBloc, DailyRewardState>(
                  builder: (context, state) {
                    if (state is SuccessDailyRewardState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                    'assets/images/daily-reward/close-btn.svg'),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white),
                                child: Text(
                                  'Daily Reward',
                                ),
                              ),
                              SizedBox(height: 5),
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                                child: Text(
                                  'Choose one of the cards and find out what bonus awaits you',
                                ),
                              ),
                            ],
                          ),
                          !_isChosen
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _indexRandomReward =
                                            Random().nextInt(3);
                                        setState(() {
                                          _isChosen = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/daily-reward/close-card.svg'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _indexRandomReward =
                                            Random().nextInt(3);
                                        setState(() {
                                          _isChosen = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/daily-reward/close-card.svg'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _indexRandomReward =
                                            Random().nextInt(3);
                                        setState(() {
                                          _isChosen = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/daily-reward/close-card.svg'),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          color: Color(0xFF402971)),
                                      child: rewards[_indexRandomReward] != 0
                                          ? Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/images/elements/coin.svg'),
                                                SizedBox(width: 5),
                                                DefaultTextStyle(
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.white),
                                                  child: Text(
                                                    '${rewards[_indexRandomReward]}',
                                                  ),
                                                ),
                                              ],
                                            )
                                          : DefaultTextStyle(
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.white),
                                              child: Text(
                                                'Better Luck in Next Time...',
                                              ),
                                            ),
                                    ),
                                    SizedBox(height: 25),
                                    ActionButtonWidget(
                                        text: rewards[_indexRandomReward] != 0
                                            ? 'Recieve'
                                            : 'OK',
                                        onTap: () {
                                          context.read<DailyRewardBloc>().add(
                                              GetDailyRewardEvent(
                                                  coins: rewards[
                                                      _indexRandomReward]));
                                          Navigator.pop(context);
                                          setState(() {});
                                        }),
                                  ],
                                ),
                          SizedBox(height: 5),
                        ],
                      );
                    } else if (state is FailureDailyRewardState) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                      'assets/images/daily-reward/close-btn.svg'),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white),
                                  child: Text(
                                    'Daily Reward',
                                  ),
                                ),
                                SizedBox(height: 5),
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white),
                                  textAlign: TextAlign.center,
                                  child: Text(
                                    'You have already collected a daily reward recently. Come back through:',
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Color(0xFF402971)),
                              child: Center(
                                child: CountdownTimer(
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
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
