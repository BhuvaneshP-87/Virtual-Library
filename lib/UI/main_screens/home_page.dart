import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:VirtualLibrary/BLoC(ViewModel)/book_bloc.dart';
import 'package:VirtualLibrary/UI/main_screens/drawer.dart';
import 'package:VirtualLibrary/UI/secondary_screens/floating%20buttons.dart';
import 'package:VirtualLibrary/UI/main_screens/category_screen.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/resources/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:VirtualLibrary/models/book.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget implements PreferredSizeWidget {

  static const String id="Home Screen";
  @override
  _HomePageState createState() => _HomePageState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{

  @override
  bool get wantKeepAlive => true;

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  BookBloc bookBloc=new BookBloc();

  getAvatar() async{
    print(user.age);
    String imagePath="avatars/${(int.parse(user.age)>50)?"oldage":(int.parse(user.age)>20)?"adult":(int.parse(user.age)>12)?"teen":"kid"}${user.gender}.jpg";
    avatarURL= await loadFromStorage(imagePath);
    print(avatarURL);
  }

  @override
  void initState() {
    getAvatar();
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
              children: [
                Container(
                  height: 250,
                  child: bannerImagesList(),
                ),
                Container(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fictional Generes",
                      style: heading,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: cataegoryImagesList(categoryList: fictionGeneres),
                        ),
                      ],
                    )
                ),
                Container(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Non-Fictional Generes",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.display2,
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: cataegoryImagesList(categoryList: nonFictionGeneres),
                        ),
                      ],
                    )
                ),
                Container(
                  height: 150,
                  child: advertisementImagesList(),
                ),
                favouriteCategories(),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget favouriteCategories(){
    List<Widget> favouriteList=[];
    print(user.categories);
    if(user.categories!=null) {
      for (var temp in user.categories) {
        favouriteList.add(startListing(categoryBook: temp));
      }
      return Column(
        children: favouriteList,
      );
    }
    else
      return Container();
  }
  Widget startListing({final categoryBook}) {
    return FutureBuilder(
      future: bookBloc.getCategoryThumbnails(category: categoryBook),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BookThumbnails> data = snapshot.data;
          List<Widget> bookList = [];
          for (BookThumbnails temp in data) {
            bookList.add(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(temp.smallThumbnail,scale: 1,),
                ));
          }
          String title="",description="";
          for(var temp in allCategoriesDescription){
            if(temp['Category']==categoryBook){
              title=temp["Category"];
              description=temp["Description"];
            }
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          style:heading
                          ),
                        Text(
                          description,
                          textAlign: TextAlign.left,
                          style: subHeading
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                CategoryScreen(category: categoryBook,)));
                      },
                    )
                  ],
                ),
              ),
              Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: bookList,
                    padding: EdgeInsets.all(0),
                  )),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget cataegoryImagesList({List categoryList}) {
    return FutureBuilder(
      future: loadCategoryImages(categoryList: categoryList),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> categoryImages = [];
          for (int i=0;i<categoryList.length;i++) {
            categoryImages.add(
                MaterialButton(
                  padding:EdgeInsets.all(5.0),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            CategoryScreen(category: categoryList[i])));
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(300.0),child: Image.network(snapshot.data[i],height:50,),),
                        Text("${categoryList[i]}",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.display2,
                              color: Colors.black87,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ));
          }
          return Container(
            height: 70,
            child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: categoryImages,
                      padding: EdgeInsets.all(0),
            ),
          );
        }
        return Container();
      },
    );
  }
  Widget bannerImagesList() {
    return FutureBuilder(
      future: loadBanner(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> bannerImages = [];
          for (String temp in snapshot.data) {
            bannerImages.add(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(temp,scale: 1.5,)),
                );
          }
          return Column(
            children: [
              Container(
                height: 250,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                    aspectRatio: 16/9,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: bannerImages,
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
  Widget advertisementImagesList() {
    return FutureBuilder(
      future: loadAdvertisement(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> bannerImages = [];
          for (String temp in snapshot.data) {
            bannerImages.add(
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(temp,scale: 1.5,)),
            );
          }
          return Column(
            children: [
              Container(
                height: 150,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                    aspectRatio: 25/9,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: bannerImages,
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
