import 'package:VirtualLibrary/BLoC(ViewModel)/book_bloc.dart';
import 'package:VirtualLibrary/components/book_cards.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/models/book.dart';
import 'package:flutter/material.dart';


class CategoryScreen extends StatefulWidget {
  CategoryScreen({this.category});
  final String category;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  BookBloc bookBloc=new BookBloc();
  int startIndex,pageCount;

  @override
  void initState() {
    startIndex=0;
    pageCount=1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 20,),
                categoryListing(category:widget.category),],
            ),
          ],
        ),
      ),
    );
  }
  Widget categoryListing({final category}){
    return FutureBuilder(
      future: bookBloc.getCategoryBookCards(category: category,startIndex: startIndex) ,
      builder: (context,snapshot) {
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
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
