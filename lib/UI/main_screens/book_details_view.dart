import 'package:VirtualLibrary/BLoC(ViewModel)/book_bloc.dart';
import 'package:VirtualLibrary/components/rounded_button.dart';
import 'package:VirtualLibrary/models/book.dart';
import 'package:VirtualLibrary/resources/user_resources.dart';
import 'package:browser_launcher/browser_launcher.dart';
import 'package:flutter/material.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';


class BookDetails extends StatefulWidget {

  static const String id='BookingScreen';
  BookDetails({this.iD,this.isBookmarked});
  final  iD,isBookmarked;

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  Book temp;
  BookBloc bookBloc=new BookBloc();
  bool isBookmarked;

  @override
  void initState() {
    print(widget.isBookmarked);
   isBookmarked=widget.isBookmarked;
    super.initState();
  }

  @override
  void dispose() {
    user.favourite.toList();
    if(temp.isbn!="") {
      if (user.favourite.contains(temp.isbn)) {
        if (isBookmarked) {}
        else
          user.favourite.remove(temp.isbn);
      }
      else {
        if (isBookmarked) {
          user.favourite.add(temp.isbn);
        }
      }
      UserResouces().updateUserDocumentInCollection(documentData: user).then(
              (value) {
            user.fromDocumentSnapshot(value);
          }
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(isBookmarked?Icons.bookmark:Icons.bookmark_border),
              onPressed: (){
                setState(() {
                  isBookmarked=!isBookmarked;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: (){
                final RenderBox box = context.findRenderObject();
                    Share.share("Hey check out this book \n ${temp.title} \n ${temp.description} \n ${temp.webLink}",
                        subject: "${temp.title} \n ${temp.description} \n ${temp.webLink}",
                        sharePositionOrigin:
                        box.localToGlobal(Offset.zero) &
                        box.size);
                  },
            ),
          ],
        ),
        body: FutureBuilder(
          future: bookBloc.getBookDetails(id: widget.iD),
          builder: (context,snapshot){
            if(snapshot.hasData) {
              temp=snapshot.data;
              print(temp.isbn);
              print(temp.description);
              return ListView(
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex:1,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.network(temp.thumbnail),
                                )),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${temp.title}",
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.display2,
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text("${temp.author.toString().substring(1,temp.author.toString().length-1)}",
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.display2,
                                          color: Colors.black87,
                                          fontSize: 15,
                                      ),

                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text("${temp.publisher}",
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context).textTheme.display2,
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),

                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text("${temp.pages} pages",
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context).textTheme.display2,
                                        color: Colors.black87,
                                        fontSize: 30,
                                      ),

                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        RoundedButton(
                          color: blue,
                          title: "Free EBook",
                          onPressed: ()async{
                            launch(temp.webLink,);
                          },
                        ),
                        temp.isDownload?
                        RoundedButton(
                          color: Colors.lightBlueAccent,
                          title: "PDF Download",
                          onPressed: ()async{
                            launch(temp.pdf);
                          },
                        ):Container(),
                        Text(
                          "Description",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.display2,
                            color: Colors.black87,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        RichText(
                          text: HTML.toTextSpan(context,"<p> ${temp.description} </p>"),
                        ),
//                        Text(
//                          HTML.toTextSpan(context, "${temp.description}"),
//                          textAlign: TextAlign.left,
//                        style: GoogleFonts.lato(
//                          textStyle: Theme.of(context).textTheme.display2,
//                          color: Colors.black87,
//                          fontSize: 15,
//                        ),),
                      ],
                    ),
                  ),
                ],
              );
          }
            else
              return Center(child: CircularProgressIndicator());
          },
        )
    );
  }
  launchURL(url) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
