import 'package:VirtualLibrary/UI/login/user_form.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/resources/firebase_storage.dart';
import 'package:VirtualLibrary/resources/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

//IntroPage UI
class OnBoardingScreen extends StatefulWidget {
  static const String id="Onboarding Screen";
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // final method = Preference().checkScreen();
  LocalStorage method = new LocalStorage();
  String onboarding1, onboarding2, onboarding3, onboarding4;
  getImageUrl() async{
    onboarding1=await loadFromStorage("Onboarding/1.png");
    onboarding2=await loadFromStorage("Onboarding/2.png");
    onboarding3=await loadFromStorage("Onboarding/3.png");
    onboarding4=await loadFromStorage("Onboarding/4.png");
    setState(() {
      onboarding1;
      onboarding2;
      onboarding3;
      onboarding4;
    });
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Center(child: Image.network(onboarding1)),
          title: "Say Goodbye to Hard-copies",
          body: "Get ready to enter into a whole new world of Virtual Books, where everything is accessible within fingertips!",
          decoration: const PageDecoration()),
      PageViewModel(
        image:Image.network(onboarding2),
        title: "Say Hello to Soft Copies",
        body: "In the EnR virtual library, we offer free access to the information about all books in our database. This feature makes the user engage with any kind of books easily and access the information instantly. ",
      ),
      PageViewModel(
        image: Image.network(onboarding3),
        title: "Search for anything",
        body: "Searching for something is becoming difficult day by day due to the plenty of resources available in the digital world! The optimised search feature available in EnR library can bring an easy solution for this problem.",
      ),
      PageViewModel(
        image: Image.network(onboarding4),
        title: "Start Building your Virtual Library",
        body: "Bookmarking your favourite books helps the reader to keep the track of all his reading books. This feature in the EnR virtual library gives the reader easy accessibilities to his favourite books and create his own Virtual library.",
      ),
    ];
  }

  @override
  void initState() {
    getImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getImageUrl();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child:  Center(
            child: (onboarding1==null)?Container():IntroductionScreen(
                globalBackgroundColor: Colors.white,
                pages: getPages(),
                showNextButton: true,
                showSkipButton: true,
                skip: Text(
                    "Skip"), //on skip press direct head to final page of Introduction
                next: Text("Next"), //on next pressed page moves one by one
                done: Text("Done "), //on done press we moved to Destination page
                onDone: () async {
                  //use of shared prefernce
                  await loginViewModel.setOnboardingStatus(true);
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Userform()));
                },
              ),
          ),
          ),
        ),
    );
  }
}
