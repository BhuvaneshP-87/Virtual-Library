import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserResouces {

  String userPath='User';
  final _firestore = Firestore.instance;

  getUserDocumentFromCollection({final documentID}) async{
    try {
      final data = await _firestore.collection(userPath)
          .document(documentID)
          .get();
      return data;
    }
    catch(error){
      return error;
    }
  }

  deleteUserDocumentFromCollection({final documentID, final context}) async {
    try {
      await _firestore.collection(userPath).document(documentID).delete();
      print("Deleted Successfully");
    }
    catch (error) {
      print(error.toString());
    }
  }

  createUserDocumentInCollection({User documentData}) async{
    try {
      loggedInUser=await FirebaseAuth.instance.currentUser();
      DocumentSnapshot document;
      var check=await _firestore.collection(userPath).where("detail",isEqualTo: loggedInUser.phoneNumber==null?loggedInUser.email:loggedInUser.phoneNumber).getDocuments();
      print(check.documents);
      if(check.documents.isEmpty) {
        DocumentReference temp=await _firestore.collection(userPath).add(documentData.toJson());
        document=await temp.get();
      }
      else {
        DocumentReference temp= check.documents[0].reference;
        await temp.updateData(documentData.toJson());
        document=await temp.get();
      }
      print("Success");
      return document;
    }
    catch (error) {
      print(error.toString());
    }
  }

  searchUser({String search}) async{
    try {
      loggedInUser=await FirebaseAuth.instance.currentUser();
      DocumentSnapshot document;
      var check=await _firestore.collection(userPath).where("detail",isEqualTo:search).getDocuments();
      print(check.documents);
      if(check.documents.isEmpty) {
        return 1;
      }
      else {
        print("Success");
        return check.documents[0];
      }
    }
    catch (error) {
      print(error.toString());
    }
  }
  updateUserDocumentInCollection({User documentData})async {
    try {
      DocumentSnapshot document;
     await  _firestore.collection(userPath).where("detail",isEqualTo: documentData.detail).getDocuments().then((value) async{
        print("Value ${value.documents}");
       await _firestore.collection(userPath).document(value.documents[0].documentID).updateData(documentData.toJson());
        await  _firestore.collection(userPath).where("detail",isEqualTo: documentData.detail).getDocuments().then((value) async {
          document=value.documents[0];
        });
      });
      print("Updated Successfully");
      return  document;
    }
    catch (error) {
      print(error.toString());
    }
  }

}