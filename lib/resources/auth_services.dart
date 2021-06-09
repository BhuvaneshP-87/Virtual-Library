import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
//  handleAuth() {
//    return StreamBuilder(
//        stream: FirebaseAuth.instance.onAuthStateChanged,
//        builder: (BuildContext context, snapshot) {
//          if (snapshot.hasData) {
//            return HomeScreen();
//          } else {
//            return LoginScreen();
//          }
//        });
//  }
  

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCreds) async {
    FirebaseAuth.instance.signInWithCredential(authCreds).then((AuthResult result)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
    }).catchError((e){
      print(e);
    });
  }

  signInWithOTP({final smsCode,final verId}) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    return authCreds;
  }

  
}
