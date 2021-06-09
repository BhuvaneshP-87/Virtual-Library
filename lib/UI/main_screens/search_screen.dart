import 'package:VirtualLibrary/components/book_cards.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/models/book.dart';
import 'package:flutter/material.dart';
import 'package:VirtualLibrary/BLoC(ViewModel)/book_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen>{

  BookBloc bookBloc=new BookBloc();
  final TextEditingController _controller = TextEditingController();
  String searchvalue;
  int startIndex,pageCount;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    startIndex=0;
    pageCount=1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
                  children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          searchvalue=value;
                        });
                        },
                      decoration: InputDecoration(
                            labelText: 'Search',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                   ),
                 ),
                    searchListing(title: searchvalue)
              ]),
        ),
        );
  }
  Widget searchListing({final title}){
    return FutureBuilder(
      future: bookBloc.searchTitleBookCards(title: title,startIndex: startIndex),
      builder:(context,snapshot) {
          if (snapshot.hasData) {
            List<BookCards> data=snapshot.data;
            if(data.length==0)
              return Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      if (startIndex > 39) {
                        setState(() {
                          startIndex -= 40;
                          pageCount--;
                          print(startIndex);
                        });
                      }
                    },
                  ),
                  Text("Sorry, no more data available!",style: heading,),
                ],
              );
            else {
              List<Widget> bookList = [];
              int totalBooks = data[0].totalBooks;
              for (BookCards temp in data) {
                bookList.add(
                    BookDesign(details: temp));
              }
              return Column(
                children: [
                  Text("Showing $totalBooks results"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          if (startIndex > 39) {
                            setState(() {
                              startIndex -= 40;
                              pageCount--;
                              print(startIndex);
                            });
                          }
                        },
                      ),
                      Text("Page $pageCount"),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () {
                          if (startIndex < (totalBooks - 80)) {
                            setState(() {
                              startIndex += 40;
                              pageCount++;
                              print(startIndex);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    semanticChildCount: bookList.length,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: bookList,
                  ),
                ],
              );
            }
//        return Text(data.toString());
          }
          else
            return Center(child: CircularProgressIndicator());
        },
    );
  }
}