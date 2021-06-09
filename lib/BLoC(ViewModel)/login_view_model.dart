import 'package:VirtualLibrary/UI/login/user_form.dart';
import 'package:VirtualLibrary/UI/main_screens/landing_page.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/UI/main_screens/home_page.dart';
import 'package:VirtualLibrary/resources/local_storage_calls.dart';
import 'package:VirtualLibrary/resources/local_storage.dart';
import 'package:VirtualLibrary/models/login_status.dart';
import 'package:VirtualLibrary/resources/auth_services.dart';
import 'package:VirtualLibrary/UI/login/login_screen.dart';
import 'package:VirtualLibrary/UI/login/onboarding_screen.dart';



class LoginViewModel{

  LoginStatus instance=new LoginStatus();


  Future setLoginStatus(value) async{
    await LocalStorage().setLoginCompleted(value);
    instance.isLoggedIn=await LocalStorage().getLoginCompleted();
  }

  Future setLanguageStatus(value) async{
    await LocalStorage().setLanguageProcessComplete(value);
    instance.isLanguageSelected= await LocalStorage().getLanguageProcessComplete();
  }

  Future setOnboardingStatus(value) async{
    await LocalStorage().setOnBoard(value);
    instance.isOnBoardingDone=await LocalStorage().getOnBoard();
  }

  Future setUserFormStatus(value) async{
    await LocalStorage().setUserForm(value);
    instance.isUserForm=await LocalStorage().getUserForm();
  }

  Future checkScreenStatus() async {
    print("Called");
    instance.isLoggedIn = await LocalStorage().getLoginCompleted();
    instance.isLanguageSelected = await LocalStorage().getLanguageProcessComplete();
    instance.isOnBoardingDone= await LocalStorage().getOnBoard();
    instance.isUserForm=await LocalStorage().getUserForm();
//    languageObject.instance.languageCode= await LocalStorageCalls().getLanguageCode();

    print("UserForm status: ${instance.isUserForm}");
    print("LoggedIn status: ${instance.isLoggedIn}");
    print("Onboarding status: ${instance.isOnBoardingDone}");

    //Cases for complete flow of module
    if (instance.isLoggedIn == null || !instance.isLoggedIn) {
      return LoginScreen();
    } else if (instance.isOnBoardingDone == null || !instance.isOnBoardingDone) {
      return OnBoardingScreen();
    } else if (instance.isUserForm == null || !instance.isUserForm) {
      return Userform();
    } else {
      return LandingPage();
    }
  }

  Future signOut()async{
    await setLoginStatus(false);
    await AuthService().signOut();
  }
}