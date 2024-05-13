part of 'coins_bloc.dart';

@immutable
sealed class CoinsEvent {}

class GetCoinsEvent extends CoinsEvent {}

class AddCoinsEvent extends CoinsEvent {
  final int value;

  AddCoinsEvent({required this.value});
}

