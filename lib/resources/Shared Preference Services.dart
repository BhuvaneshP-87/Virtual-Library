import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  bool isNew, loggedIn, onboard;

  Future<bool> setIsNewProcessComplete(bool bol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNew', bol);
    return true;
  }

  Future<bool> getIsNewProcessComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isNew = prefs.getBool("isNew");
    return isNew;
  }

  Future<bool> setLoginCompleted(bool bol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', bol);
    return true;
  }

  Future<bool> getLoginCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool("loggedIn");
    return loggedIn;
  }

  Future<bool> setOnBoard(bool bol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboard', bol);
    return true;
  }

  Future<bool> getOnBoard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onboard = prefs.getBool("onboard");
    print("$onboard");
    return onboard;
  }
}