import 'package:VirtualLibrary/BLoC(ViewModel)/book_bloc.dart';
import 'package:VirtualLibrary/UI/secondary_screens/floating%20buttons.dart';
import 'package:VirtualLibrary/components/book_cards.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:flutter/material.dart';
import 'package:VirtualLibrary/models/book.dart';

class PersonalLibrary extends StatefulWidget implements PreferredSizeWidget {

  static const String id="Personal Library";
  @override
  _PersonalLibraryState createState() => _PersonalLibraryState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _PersonalLibraryState extends State<PersonalLibrary>{

  BookBloc bookBloc=new BookBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${user.name}'s Library,",style: heading,),
                ),
                personalLibrary(bookList: user.favourite),
              ]
            )
          ],
        ),
      ),
    );
  }

  Widget personalLibrary({List bookList}){
    return FutureBuilder(
      future: bookBloc.getPersonalLibrary(bookList: bookList) ,
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          List<BookCards> data=snapshot.data;
          List<Widget> bookList=[];
          for(BookCards temp in data){
            bookList.add(BookDesign(details: temp));
          }
          return Column(
            children: [
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: bookList,
              ),
            ],
          );
//        return Text(data.toString());
        }
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
