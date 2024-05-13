import 'package:bloc/bloc.dart';
import 'package:lords_palace_app/services/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'daily_reward_event.dart';
part 'daily_reward_state.dart';

class DailyRewardBloc extends Bloc<DailyRewardEvent, DailyRewardState> {
  DailyRewardBloc() : super(DailyRewardInitial()) {
    on<GetDailyRewardEvent>(_getDailyRewardHandler);
    on<CheckDailyRewardEvent>(_checkDailyRewardHandler);
  }

  void _checkDailyRewardHandler(
      CheckDailyRewardEvent event, Emitter<DailyRewardState> emit) async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final int twentyFourHours = 24 * 60 * 60 * 1000;

    if (currentTime - storage.lastRewardTime >= twentyFourHours) {
      emit(SuccessDailyRewardState());
    } else {
      final int _timeLeft =
          twentyFourHours - (currentTime - storage.lastRewardTime);
      emit(FailureDailyRewardState(timeLeft: _timeLeft));    }
  }

  void _getDailyRewardHandler(
      GetDailyRewardEvent event, Emitter<DailyRewardState> emit) async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final int twentyFourHours = 24 * 60 * 60 * 1000;
    storage.coins += event.coins;
    storage.lastRewardTime = currentTime;
    final int _timeLeft =
        twentyFourHours - (currentTime - storage.lastRewardTime);
    emit(FailureDailyRewardState(timeLeft: _timeLeft));
  }
}
