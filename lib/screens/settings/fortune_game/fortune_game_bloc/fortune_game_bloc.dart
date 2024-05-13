import 'package:bloc/bloc.dart';
import 'package:lords_palace_app/services/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'fortune_game_event.dart';

part 'fortune_game_state.dart';

class FortuneGameBloc extends Bloc<FortuneGameEvent, FortuneGameState> {
  FortuneGameBloc() : super(FortuneGameInitial()) {
    on<GetFortuneCoinsEvent>(_getFortuneCoinsHandler);
    on<CheckFortuneGameEvent>(_checkFortuneGameHandler);
  }

  void _checkFortuneGameHandler(
      CheckFortuneGameEvent event, Emitter<FortuneGameState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final int twentyFourHours = 24 * 60 * 60 * 1000;

    if (currentTime - storage.lastFortuneTime >= twentyFourHours) {
      emit(SuccessFortuneGameState());
    } else {
      final int _timeLeft =
          twentyFourHours - (currentTime - storage.lastFortuneTime);
      emit(FailureFortuneGameState(timeLeft: _timeLeft));
    }
  }

  void _getFortuneCoinsHandler(
      GetFortuneCoinsEvent event, Emitter<FortuneGameState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final int twentyFourHours = 24 * 60 * 60 * 1000;
    storage.coins += event.coins;
    storage.lastFortuneTime = currentTime;
    final int _timeLeft =
        twentyFourHours - (currentTime - storage.lastFortuneTime);
    emit(FailureFortuneGameState(timeLeft: _timeLeft));
  }
}
