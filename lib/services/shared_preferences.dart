import 'package:shared_preferences/shared_preferences.dart';

const String _kcoinsKey = 'coins';
const String _klastRewardTimeKey = 'lastRewardTime';
const String _klastFortuneTimeKey = 'lastFortuneTime';


class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  dynamic _getData(String key) {
    var value = _preferences.get(key);

    print('Retrieved $key: $value');

    return value;
  }

  void _saveData(String key, dynamic value) {
    print('Saving $key: $value');

    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

  int get coins => _getData(_kcoinsKey) ?? 0;
  set coins(int value) => _saveData(_kcoinsKey, value);

  int get lastRewardTime => _getData(_klastRewardTimeKey) ?? 0;
  set lastRewardTime(int value) => _saveData(_klastRewardTimeKey, value);

  int get lastFortuneTime => _getData(_klastFortuneTimeKey) ?? 0;
  set lastFortuneTime(int value) => _saveData(_klastFortuneTimeKey, value);
}