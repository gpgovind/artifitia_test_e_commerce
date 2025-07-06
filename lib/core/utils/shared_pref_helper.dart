import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final String keyEmail = 'user_email';


  final SharedPreferences _prefs;

  SharedPrefHelper(this._prefs);

  Future<void> saveUser({required String email}) async {
    await _prefs.setString(keyEmail, email);
  }

  String? get userEmail => _prefs.getString(keyEmail);

  Future<void> clearUser() async {
    await _prefs.remove(keyEmail);
  }
}
