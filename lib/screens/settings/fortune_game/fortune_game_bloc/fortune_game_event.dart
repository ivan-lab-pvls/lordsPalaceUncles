part of 'fortune_game_bloc.dart';

@immutable
sealed class FortuneGameEvent {}

class GetFortuneCoinsEvent extends FortuneGameEvent {
  final int coins;

  GetFortuneCoinsEvent({required this.coins});
}

class CheckFortuneGameEvent extends FortuneGameEvent {}