import 'package:VirtualLibrary/UI/login/onboarding_screen.dart';
import 'package:VirtualLibrary/UI/login/user_form.dart';
import 'package:VirtualLibrary/components/rounded_button.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseUser _user;

  @override
  void initState() {
    _user=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset("assets/logo.png",scale: 8,),
                  SizedBox(height: 180,),
                  _user==null?RoundedButton(
                    title: "Google",
                    color: Colors.redAccent,
                    onPressed: googleLogin,
                  ):Container(),
                  _user==null?RoundedButton(
                    title: "Phone",
                    color: Colors.blueAccent,
                    onPressed: phoneLogin,
                  ):Container(),
                  _user!=null?RoundedButton(
                    title: "Get Started",
                    color: blue,
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));
                    },
                  ):Container(),
                ],
              ),
            )
        ),
      ),
    );
  }


  void googleLogin() {
    if (_user == null) {
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.google(),
      ]).then((firebaseUser) async{
        await loginViewModel.setLoginStatus(true);
        setState(() {

          _user = firebaseUser;
        });
      }).catchError((error) {
        print(error);
      });
    }
  }
  void phoneLogin() {
    if (_user == null) {
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.phone(),
      ]).then((firebaseUser) async{
        await loginViewModel.setLoginStatus(true);
        setState(() {
          _user = firebaseUser;
        });
      }).catchError((error) {
        print(error);
      });
    }
  }
}





//import 'package:enr_library_app/UI/login/otp_verification.dart';
//import 'package:enr_library_app/components/rounded_button.dart';
//import 'package:flutter/material.dart';
//import 'package:country_code_picker/country_code_picker.dart';
//import 'package:enr_library_app/constants.dart';
//
//

//class LoginScreen extends StatefulWidget {
//  static const String id='Login Screen';
//  @override
//  _LoginScreenState createState() => _LoginScreenState();
//}
//
//class _LoginScreenState extends State<LoginScreen> {
//
//  //formkey used for login method
//  final formKey = new GlobalKey<FormState>();
//  //variables used
//  String phoneNo, smsCode,countryCode;
//
//  @override
//  void initState() {
//   countryCode="+91";
//    super.initState();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        backgroundColor: Colors.black87,
//        body: Column(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: [
//            Material(
//              borderRadius: BorderRadius.circular(20),
//              color: Colors.white,
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Flexible(
//                        child: CountryCodePicker(
//                          onChanged: (value){
//                            countryCode=value.toString();
//                          },
//                          initialSelection: 'IN',
//                          favorite: ['+91','IN'],
//                          showCountryOnly: false,
//                          showOnlyCountryWhenClosed: false,
//                          alignLeft: false,
//                        ),
//                        flex: 3,
//                      ),
//                      Flexible(
//                        child: new TextFormField(
//                          onChanged: (value){
//                            phoneNo=value;
//                          },
//                          decoration: InputDecoration(hintText: "Enter Phone Number"),
//                          textAlign: TextAlign.start,
//                          autofocus: false,
//                          enabled: true,
//                          keyboardType: TextInputType.number,
//                          textInputAction: TextInputAction.done,
//                          style: TextStyle(fontSize: 20.0, color: Colors.black),
//                        ),
//                        flex: 10,
//                      ),
//                    ],
//                  ),
//                  SizedBox(height: 10,),
//                  Padding(
//                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                    child: RoundedButton(
//                        color:Colors.blue ,
//                        title:"Verify Your Phone",
//                        onPressed: () async{
//                              await loginViewModel.verifyPhone(phoneNo:countryCode+phoneNo);
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPverification()));
//                        },
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//  //Firebase part
//}


