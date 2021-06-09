import 'package:VirtualLibrary/UI/main_screens/book_details_view.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/models/book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDesign extends StatelessWidget {
  BookDesign({@required this.details});
  BookCards  details;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        print(user.favourite);
        print(details.isbn);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails(iD: details.id,isBookmarked: user.favourite.contains(details.isbn),)));
      },
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
              child: Align(
                widthFactor: 1,
                  heightFactor: 0.5,
                  child: Image.network(details.smallThumbnail,height: 180,width: 140,))),
          Text(" ${details.title}",style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.display2,
              color: Colors.black87,
              fontSize: 12,
            fontWeight: FontWeight.bold
          ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,),
          (details.author!=null)?Text(
            " ${details.author.toString().substring(1,details.author.toString().length-1)}",
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.display2,
                color: Colors.black87,
                fontSize: 10,
                fontStyle: FontStyle.italic),
            overflow: TextOverflow.ellipsis,):Container()
        ],),
    );
  }
}
