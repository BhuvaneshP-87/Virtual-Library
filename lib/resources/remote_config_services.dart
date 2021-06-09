import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:convert';

class RemoteConfigServices {

  Future setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    remoteConfig.setDefaults(<String, dynamic>{
      "0": {"languageName": "English", "languageCode": "EN"},
    });
    return remoteConfig;
  }

  Future fetchRemoteConfigData(RemoteConfig remoteConfig) async {
    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 4));
      await remoteConfig.activateFetched();
      return remoteConfig;
    } catch (exception) {
      print(exception);
    }
  }

  Future getLanguageList(RemoteConfig remoteConfig) async{
    Map temp=await json.decode(remoteConfig.getString("languageList"));
    return temp;
  }
}
