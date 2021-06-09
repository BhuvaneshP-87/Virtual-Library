import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  Future setLanguageProcessComplete(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLanguageSelected', value);
  }

  Future getLanguageProcessComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLanguageSelected");
  }

  Future setLoginCompleted(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
  }

  Future getLoginCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn");
  }

  Future setOnBoard(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnBoardingDone', value);
  }

  Future getOnBoard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isOnBoardingDone");
  }
  Future setUserForm(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserForm', value);
  }

  Future getUserForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isUserForm");
  }
}
