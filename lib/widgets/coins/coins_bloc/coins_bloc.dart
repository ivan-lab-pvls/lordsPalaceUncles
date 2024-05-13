import 'package:bloc/bloc.dart';
import 'package:lords_palace_app/services/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'coins_event.dart';
part 'coins_state.dart';

class CoinsBloc extends Bloc<CoinsEvent, CoinsState> {
  CoinsBloc() : super(CoinsInitial()) {
    on<GetCoinsEvent>(_getCoinsHandler);
    on<AddCoinsEvent>(_addCoinsHandler);
  }

  void _getCoinsHandler(
      GetCoinsEvent event, Emitter<CoinsState> emit) async {
    SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    emit(UpdateCoinsState(
        coins: storage.coins));
  }

  void _addCoinsHandler(
      AddCoinsEvent event, Emitter<CoinsState> emit) async {
    SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    storage.coins += event.value;
    emit(UpdateCoinsState(
        coins: storage.coins));
  }
}
