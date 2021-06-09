import 'package:VirtualLibrary/UI/login/login_screen.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/resources/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:VirtualLibrary/UI/secondary_screens/account.dart';
import 'package:VirtualLibrary/UI/secondary_screens/help.dart';
import 'package:share/share.dart';

class DrawerPart extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:ListView(
            children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(" ${user.name}",style: heading,),
                  accountEmail: Text(" ${user.detail}",style: subHeading,),
                  currentAccountPicture: CircleAvatar(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: Image.network(avatarURL,scale: 2,)),
                  ),
                ),
              ListTile(
                leading: Icon(Icons.person_outline,color: blue,),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Account()));
                },
                title: Text("Account",
                    style: subHeading),
              ),
//              ListTile(
//                leading: Icon(Icons.settings),
//                onTap: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => Settings()));
//                },
//                title: Text("Settings",
//                    style: TextStyle(fontStyle: FontStyle.italic)),
//              ),
              ListTile(
                leading: Icon(Icons.help,color: blue,),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Help()));
                },
                title:
                Text("Help", style: subHeading),
              ),
              ListTile(
                  leading: Icon(Icons.exit_to_app,color: blue,),
                  title: Text("Sign Out",style: subHeading),
                  onTap: () async{
                    loginViewModel.signOut();
                    await loginViewModel.setUserFormStatus(false);
                    await loginViewModel.setLoginStatus(false);
                    await loginViewModel.setOnboardingStatus(false);
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
//              ListTile(
//                  leading: Icon(Icons.share),
//                  title: Text("Share",style: TextStyle(fontStyle: FontStyle.italic)),
//                  onTap: () {
//                    final RenderBox box = context.findRenderObject();
//                    Share.share("HEY",
//                        subject: "SSupp?",
//                        sharePositionOrigin:
//                        box.localToGlobal(Offset.zero) &
//                        box.size);
//                  }),
            ],
          ),
    );
  }
}
