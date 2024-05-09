import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPreferencesManager {
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  Future<bool> setLocations(List<String> locations) async {
    return await (await _sharedPreferences).setStringList('locations', locations);
  }

  Future<List<String>> getLocations() async {
    return (await _sharedPreferences).getStringList('locations') ?? List.empty();
  }
}
