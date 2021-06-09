import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  String _name,_detail;
  DateTime _createdAt,_lastOpenedAt,_lastSignInAt;
  String _age;
  int _gender;
  List _categories,_favourite;

  User({List categories,List favourite,String age,int gender,String detail,String name,String address,double latitude, double longitude, String referral,
    DateTime createdAt,DateTime lastOpenedAt,DateTime lastSignInAt}){
    this._favourite=favourite;
    this._name=name;
    this._age=age;
    this._gender=gender;
    this._detail=detail;
    this._categories=categories;
    this._createdAt=createdAt;
    this._lastOpenedAt=lastOpenedAt;
    this._lastSignInAt=lastSignInAt;
  }

  fromDocumentSnapshot(DocumentSnapshot json) {
    _name=json['name']==null?"":json['name'];
    _age=json['age']==null?"12":json['age'];
    _gender=json['gender']==null?1:json['gender'];
    _detail=json['detail'];
    _categories=json['categories']==null?[]:json['categories'];
    _createdAt=json['createdAt'].toDate();
    _lastOpenedAt=json['lastOpenedAt'].toDate();
    _lastSignInAt=json['lastSignInAt'].toDate();
    _favourite=json['favourite']==null?[].toList():json['favourite'].toList();
  }

  Map<String, dynamic> toJson() =>
      {
        'name': _name,
        'age': _age,
        'gender': _gender,
        'detail': _detail,
        'categories': _categories,
        'createdAt': _createdAt,
        'lastOpenedAt': _lastOpenedAt,
        'lastSignInAt': _lastSignInAt,
        'favourite':_favourite==null?[]:_favourite,
      };

  get detail => _detail;

  set detail(value) {
    _detail = value;
  }


  String get age => _age;

  set age(String value) {
    _age = value;
  }

  get emailId => _detail;

  List get categories => _categories;

  set categories(List value) {
    _categories = value;
  }

  set emailId(value) {
    _detail = value;
  }


  get lastSignInAt => _lastSignInAt;

  set lastSignInAt(value) {
    _lastSignInAt = value;
  }

  get lastOpenedAt => _lastOpenedAt;

  set lastOpenedAt(value) {
    _lastOpenedAt = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get gender => _gender;

  set gender(int value) {
    _gender = value;
  }

  List get favourite => _favourite;

  set favourite(List value) {
    _favourite = value;
  }
}
