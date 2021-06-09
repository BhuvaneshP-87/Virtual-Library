import 'package:flutter/material.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.color,this.title,@required this.onPressed});
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:10.0),
      child: Material(
        color:color,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          height: 42.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  title,
                  style:GoogleFonts.lato(
                    color: white,
                    textStyle: Theme.of(context).textTheme.display2,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}