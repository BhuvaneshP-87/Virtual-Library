import 'package:VirtualLibrary/models/user.dart';
import 'package:VirtualLibrary/BLoC(ViewModel)/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String avatarURL;
FirebaseUser loggedInUser;
LoginViewModel loginViewModel=new LoginViewModel();
//LanguageViewModel languageObject=new LanguageViewModel();
User user=new User();
Color blue=Color(0xff59bfff);
Color white=Color(0xffffffff);

TextStyle heading= GoogleFonts.lato(
color: Colors.black87,
fontSize: 20,
fontWeight: FontWeight.bold);

TextStyle description=GoogleFonts.lato(
  color: Colors.black87,
  fontSize: 12,);

TextStyle subHeading=GoogleFonts.lato(
  color: Colors.black87,
  fontStyle: FontStyle.italic,
  fontSize: 15,);

getList(){
  List<Map> categoryList=new List();
  for(String temp in allCategories){
    categoryList.add(
      {
        "display": temp,
        "value": temp,
      },
    );
  }
  return categoryList;
}
List<Map> allCategoriesDescription=[
{
"Category": "Fantasy",
"Description": "Inspired by an imaginary universe!"
},
{
"Category": "Science Fiction",
"Description": "Fascinating imaginative and futuristic concepts !"
},
{
"Category": "Dystopian",
"Description": "Fictional writing with social and political structures !"
},
{
"Category": "Adventure",
"Description": "Engaging experience ahead!"
},
{
"Category": "Romance",
"Description": "Focus on the love and romance!"
},
{
"Category": "Detective & Mystery",
"Description": "Gripping crime and mystery stories!"
},
{
"Category": "Horror",
"Description": "Speculative fiction to scare you!"
},
{
"Category": "Thriller",
"Description": "Get ready for breathtaking experience!"
},
{
"Category": "LGBTQ+",
"Description": "Mixed with romance, fantasy!"
},
{
"Category": "Historical Fiction",
"Description": "Get amazed by the past!"
},
{
"Category": "Young Adult Fiction",
"Description": "Exclusively for age 13 to 18!"
},
{
"Category": "Kids",
"Description": "Picture books and easy-to-read stories!"
},
{
"Category": "Autobiography",
"Description": "Self-written account of the life of oneself!"
},
{
"Category": "Biography",
"Description": "More than just the basic facts!"
},
{
"Category": "Cooking",
"Description": "Yummy recipes for Tummy!"
},
{
"Category": "Art & Photography",
"Description": "Let your imagination speak!"
},
{
"Category": "Personal Development",
"Description": "Develop your life style for the better!"
},
{
"Category": "Motivational / Inspirational",
"Description": "Let the motivation change you!"
},
{
"Category": "Health & Fitness",
"Description": "Healthy Living & Wellness!"
},
{
"Category": "History",
"Description": "Only true stories!"
},
{
"Category": "Hobby",
"Description": "Waking up the creative person in you!"
},
{
"Category": "Family",
"Description": "Giving you the wisdom you need! "
},
{
"Category": "Humor & Entertainment",
"Description": "Happy mood!"
},
{
"Category": "Business & Money",
"Description": "Enriching the life of a reader!"
},
{
"Category": "Law & Criminology",
"Description": "Opening your eyes to the real world !"
},
{
"Category": "Politics & Social Sciences",
"Description": "Enlightening you with the duty of a citizen!"
},
{
"Category": "Religion & Spirituality",
"Description": "Enlightening your inner soul!"
},
{
"Category": "Education & Teaching",
"Description": "Bringing up the brighter students!"
},
{
"Category": "Travel",
"Description": "Experience the virtual travelling!"
},
{
"Category": "True Crime",
"Description": "Real adventure and thrill!"
}
];
List<String> allCategories=[
  "Fantasy",
  "Science Fiction",
  "Dystopian",
  "Adventure",
  "Romance",
  "Detective & Mystery",
  "Horror",
  "Thriller",
  "LGBTQ+",
  "Historical Fiction",
  "Young Adult Fiction",
  "Kids",
  "Autobiography",
  "Biography",
  "Cooking",
  "Art & Photography",
  "Personal Development",
  "Health & Meditation",
  "History",
  "Hobby",
  "Family",
  "Humor & Entertainment",
  "Business & Money",
  "Law & Criminology",
  "Politics & Social Sciences",
  "Religion & Spirituality",
  "Education & Teaching",
  "Travel",
  "True Crime"
];
List<String> fictionGeneres=[
  "Fantasy",
"Science Fiction",
"Dystopian",
"Adventure",
"Romance",
"Detective & Mystery",
"Horror",
"Thriller",
"LGBTQ+",
"Historical Fiction",
"Young Adult Fiction",
"Kids",
  ];
List<String> nonFictionGeneres=[
  "Autobiography",
"Biography",
"Cooking",
"Art & Photography",
"Personal Development",
"Health & Meditation",
"History",
"Hobby",
"Family",
"Humor & Entertainment",
"Business & Money",
"Law & Criminology",
"Politics & Social Sciences",
"Religion & Spirituality",
"Education & Teaching",
"Travel",
"True Crime"
];
//void CategoryListDataUpdate()
//{
//  for(int i=0;i<30;i++) {
//    _firestore.collection('Category List').document("Hindi").updateData({
//      "${category[i]["category"]}": {"description": category1[i]["description"],
//        "name": category1[i]["category"],
//      }
//    });
//  }
//}