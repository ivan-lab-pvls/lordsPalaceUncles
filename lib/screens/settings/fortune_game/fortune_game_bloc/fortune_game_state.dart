part of 'fortune_game_bloc.dart';

@immutable
sealed class FortuneGameState {}

final class FortuneGameInitial extends FortuneGameState {}

class SuccessFortuneGameState extends FortuneGameState {}

class FailureFortuneGameState extends FortuneGameState {
  final int timeLeft;

  FailureFortuneGameState({required this.timeLeft});
}