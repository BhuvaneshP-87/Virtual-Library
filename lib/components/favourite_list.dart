//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ise_library/components/Bookings%20Cards.dart';
//
//class BookingList extends StatelessWidget {
//  BookingList({this.email});
//  final email;
//
//
//  @override
//  Widget build(BuildContext context,) {
//
//    return StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance.collection('Bookings').snapshots(),
//        builder: (context, snapshot){
//          if (!snapshot.hasData) {
//            return Center(
//              child: CircularProgressIndicator(
//                backgroundColor: Colors.lightBlueAccent,
//              ),
//            );
//          }
//          final bookingList = snapshot.data.documents;
//          print("YESS");
//          print(bookingList);
//          List<Widget> bookingListCatalogue=[];
//          for (var booking in bookingList){
//            if (booking.data['email'].toString().compareTo(email)==0)
//              {
//                bookingListCatalogue.add(
//                  BookingDesign(
//                    bookDetails: booking.data['details'],
//                    bookingDetails: booking,
//                  ),
//                );
////                print(booking.data['details'].toString());
//              }
//          }
//              return ListView(
//                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//                children: bookingListCatalogue,
//              );
//          }
//    );
//  }
//}
