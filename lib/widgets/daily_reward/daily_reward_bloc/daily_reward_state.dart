part of 'daily_reward_bloc.dart';

@immutable
abstract class DailyRewardState {}

class DailyRewardInitial extends DailyRewardState {}

class SuccessDailyRewardState extends DailyRewardState {}

class FailureDailyRewardState extends DailyRewardState {
  final int timeLeft;

  FailureDailyRewardState({required this.timeLeft});
}