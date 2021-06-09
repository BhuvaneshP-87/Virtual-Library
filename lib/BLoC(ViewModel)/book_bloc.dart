import 'package:VirtualLibrary/models/book.dart';
import 'package:VirtualLibrary/resources/api_calls.dart';
import 'package:flutter/material.dart';

class BookBloc{

  getCategoryThumbnails({final category})async {
    List<BookThumbnails> bookList=[];
    var tempData=await ApiCalls().getCategory(category: category,startIndex: 0);
    for(int i=0;i<20;i++){
      BookThumbnails temp=BookThumbnails();
      if(tempData["items"][i]["volumeInfo"]["imageLinks"]["smallThumbnail"]==null)
        continue;
      temp.smallThumbnail=tempData["items"][i]["volumeInfo"]["imageLinks"]["smallThumbnail"];
      bookList.add(temp);
    }
    return bookList;
  }

  getCategoryBookCards({final category,final startIndex}) async{
    List<BookCards> bookList=[];
    var tempData=await ApiCalls().getCategory(category: category,startIndex: startIndex);
    for(int i=0;i<20;i++){
      BookCards temp=BookCards();
      try {
        if (tempData["items"] != null) {
          temp.id = tempData["items"][i]["id"];
          if (tempData["items"][i]["volumeInfo"]["title"] == null)
            continue;
          temp.title = tempData["items"][i]["volumeInfo"]["title"];

          if (tempData["items"][i]["volumeInfo"]["imageLinks"]["thumbnail"] ==
              null)
            continue;
          temp.smallThumbnail =
          tempData["items"][i]["volumeInfo"]["imageLinks"]["thumbnail"];

          if (tempData["items"][i]["volumeInfo"]["authors"] == [])
            continue;
          temp.author = tempData["items"][i]["volumeInfo"]["authors"];
          temp.totalBooks = tempData["totalItems"];
          if(tempData["items"][i]["volumeInfo"]['industryIdentifiers']==null)
            temp.isbn="";
          else {
            for (int j = 0; j <
                tempData["items"][i]["volumeInfo"]['industryIdentifiers']
                    .length; j++) {
              if (tempData["items"][i]["volumeInfo"]["industryIdentifiers"][j]['type'] ==
                  "ISBN_10")
                temp.isbn =
                tempData["items"][i]["volumeInfo"]["industryIdentifiers"][j]['identifier'];
            }
          }
          bookList.add(temp);
        }
      }
      catch(e){
        print(e);
      }
    }
    return bookList;
  }

  getPersonalLibrary({List bookList}) async{
    List<BookCards> bookDetailsList=[];
    for(String isbn in bookList){
      try {
        var tempData = await ApiCalls().getBookISBN(isbn: isbn);
        BookCards temp = BookCards();
        if (tempData["items"] != null) {
          temp.id = tempData["items"][0]["id"];
          if (tempData["items"][0]["volumeInfo"]["title"] == null)
            continue;
          temp.title = tempData["items"][0]["volumeInfo"]["title"];

          if (tempData["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"] ==
              null)
            continue;
          temp.smallThumbnail =
          tempData["items"][0]["volumeInfo"]["imageLinks"]["smallThumbnail"];

          if (tempData["items"][0]["volumeInfo"]["authors"] == [])
            continue;
          temp.author = tempData["items"][0]["volumeInfo"]["authors"];
          if(tempData["items"][0]["volumeInfo"]['industryIdentifiers']==null)
            temp.isbn="";
          else {
            for (int j = 0; j <
                tempData["items"][0]["volumeInfo"]['industryIdentifiers']
                    .length; j++) {
              if (tempData["items"][0]["volumeInfo"]["industryIdentifiers"][j]['type'] ==
                  "ISBN_10")
                temp.isbn =
                tempData["items"][0]["volumeInfo"]["industryIdentifiers"][j]['identifier'];
            }
          }
          bookDetailsList.add(temp);
        }
      }catch(e){
        print(e);
      }
    }
    return bookDetailsList;
  }

  searchTitleBookCards({final title,final startIndex}) async{
    List<BookCards> bookList=[];
    var tempData=await ApiCalls().getBook(title: title,startIndex: startIndex);
    int n;
    if(tempData["totalItems"]>40){
      n=40;
    }
    else
      n=tempData["totalItems"];
    for(int i=0;i<n;i++){
      BookCards temp=BookCards();
      temp.id=tempData["items"][i]["id"];
      if(tempData["items"][i]["volumeInfo"]["title"]==null)
        continue;
      temp.title=tempData["items"][i]["volumeInfo"]["title"];

      if(tempData["items"][i]["volumeInfo"]["imageLinks"]==null)
        temp.smallThumbnail="https://www.engagenreap.com/images/enr_consultancy_services.png";
      else
      temp.smallThumbnail=tempData["items"][i]["volumeInfo"]["imageLinks"]["thumbnail"];

      if(tempData["items"][i]["volumeInfo"]["authors"]==[])
        continue;
      temp.author=tempData["items"][i]["volumeInfo"]["authors"];
      temp.totalBooks = tempData["totalItems"];
      if(tempData["items"][i]["volumeInfo"]['industryIdentifiers']==null)
        temp.isbn="";
      else {
        for (int j = 0; j <
            tempData["items"][i]["volumeInfo"]['industryIdentifiers']
                .length; j++) {
          if (tempData["items"][i]["volumeInfo"]["industryIdentifiers"][j]['type'] ==
              "ISBN_10")
            temp.isbn =
            tempData["items"][i]["volumeInfo"]["industryIdentifiers"][j]['identifier'];
        }
      }
      bookList.add(temp);
    }
    return bookList;
  }

  getBookDetails({final id})async{
    var tempData=await ApiCalls().getBookDetails(id: id);
    Book temp=Book();

    if(tempData["volumeInfo"]["title"]==null)
      temp.title=" ";
    temp.title=tempData["volumeInfo"]["title"];

    if(tempData["volumeInfo"]["imageLinks"]==null)
      temp.thumbnail=" ";
    temp.thumbnail=tempData["volumeInfo"]["imageLinks"]["thumbnail"];

    if(tempData["accessInfo"]["webReaderLink"]==null)
      temp.webLink=" ";
    temp.webLink=tempData["accessInfo"]["webReaderLink"];

    if(tempData["volumeInfo"]["description"]==null)
      temp.description=" ";
    temp.description=tempData["volumeInfo"]["description"];

    if(tempData["volumeInfo"]["authors"]==null)
      temp.author=[];
    temp.author=tempData["volumeInfo"]["authors"];

    if(tempData["volumeInfo"]["publisher"]==null)
      temp.publisher=" ";
    temp.publisher=tempData["volumeInfo"]["publisher"];

    if(tempData["accessInfo"]["pdf"]["isAvailable"]==false)
      temp.isDownload=false;
    else{
    temp.isDownload=true;
    temp.pdf=tempData["accessInfo"]["pdf"]["acsTokenLink"];
    }

    if(tempData["volumeInfo"]["pageCount"]==null)
      temp.pages=3;
    temp.pages=tempData["volumeInfo"]["pageCount"];
    if(tempData["volumeInfo"]['industryIdentifiers']==null)
      temp.isbn="";
    else {
      for (int i = 0; i <
          tempData["volumeInfo"]['industryIdentifiers']
              .length; i++) {
        if (tempData["volumeInfo"]["industryIdentifiers"][i]['type'] ==
            "ISBN_10")
          temp.isbn =
          tempData["volumeInfo"]["industryIdentifiers"][i]['identifier'];
      }
    }
    return temp;

  }

}