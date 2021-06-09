import 'dart:io';
import 'dart:ui';
import 'package:VirtualLibrary/UI/main_screens/home_page.dart';
import 'package:VirtualLibrary/components/rounded_button.dart';
import 'package:VirtualLibrary/constants.dart';
import 'package:VirtualLibrary/resources/user_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  checkForInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  String gender;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if(user.gender==1)
      gender="Male";
    else if(user.gender==2)
      gender="Female";
    else
      gender="Others";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: user.name,
                            onChanged: (value){
                              user.name=value;
                            },
                            decoration:InputDecoration(
                              labelText: 'Name',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color(0xff59bfff),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            validator:(value){
                              if(value.contains(new RegExp(r'[A-Za-z]')))
                                return null;
                              else
                                return "Please enter a valid name";
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            child: TextFormField(
                              initialValue: user.age,
                              keyboardType: TextInputType.number,
                              onChanged:(value){
                                user.age=value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Age',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(0xff59bfff),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              validator:(value){
                                if(value.isNotEmpty && int.parse(value)>0 && int.parse(value)<120)
                                  return null;
                                else
                                  return "Please enter a valid age";
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 55,
                            decoration:new BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(color: Colors.black87)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                elevation: 0,
                                focusColor: Color(0xff59bfff),
                                hint: Text("Gender"),
                                value: gender,
                                underline: Container(),
                                icon: Icon(Icons.arrow_drop_down,size: 30,),
                                iconSize: 30,
                                onChanged: (String newValue) {
                                  setState(() {
                                    gender = newValue;
                                    if(gender=="Male")
                                      user.gender=1;
                                    else if(gender=="Female")
                                      user.gender=2;
                                    else
                                      user.gender=0 ;
                                  });
                                },
                                items: <String>['Male', 'Female', 'Others']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: MultiSelectFormField(
                              initialValue: user.categories,
                              autovalidate: false,
                              titleText: 'My Categories',
                              validator: (value) {
                                if (value == null || value.length == 0) {
                                  return 'Please select one or more options';
                                }
                              },
                              dataSource: getList(),
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                ),
                              ),
                              hintText: 'Please choose one or more',
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  user.categories= value;
                                });
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Builder(
                            builder: (context) {
                              return RoundedButton(
                                title:"Save",
                                color: Color(0xff59bfff),
                                onPressed: () async{
                                  if (_formKey.currentState.validate()) {
                                    bool connected = await checkForInternet();
                                    if (connected) {
                                      loggedInUser=await FirebaseAuth.instance.currentUser();
                                      user.detail = (loggedInUser.phoneNumber == null ||loggedInUser.phoneNumber=="")
                                          ? loggedInUser.email
                                          : loggedInUser.phoneNumber;
                                      user.lastSignInAt = DateTime.now();
                                      user.lastOpenedAt = DateTime.now();
                                      print(user.detail);
                                      user.fromDocumentSnapshot(await UserResouces()
                                          .updateUserDocumentInCollection(
                                          documentData: user));
                                    }
                                    else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("No Internet")));
                                    }
                                  }
                                },
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

