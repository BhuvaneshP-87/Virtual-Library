import 'package:VirtualLibrary/UI/main_screens/drawer.dart';
import 'package:VirtualLibrary/UI/main_screens/home_page.dart';
import 'package:VirtualLibrary/UI/main_screens/personal_library.dart';
import 'package:VirtualLibrary/UI/main_screens/search_screen.dart';
import 'package:flutter/material.dart';


class FloatingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: Icon(Icons.search,),
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.home,),
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PersonalLibrary()));
            },
            icon :Icon(Icons.local_library,),
          ),
        ),
      ],
    );
  }
}
