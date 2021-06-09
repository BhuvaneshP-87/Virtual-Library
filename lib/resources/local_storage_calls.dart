import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageCalls {

  Future setLanguageCode(String language_code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("languageCode", language_code);
  }

  Future getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("languageCode");
  }
}