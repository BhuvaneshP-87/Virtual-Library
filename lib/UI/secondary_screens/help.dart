import 'package:VirtualLibrary/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Help'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Contact Us 24x7 for any queries, feedback or feature request",
              style: heading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
              onPressed: (){
                FlutterOpenWhatsapp.sendSingleMessage("+91 8904889694", "Hello, I need a help with EnR Virtual Library");
                },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(Icons.whatshot,color: blue,),
                      ),
                      Text("Contact on WhatsApp")
                    ],
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
            onPressed: (){
              launch('tel: +91 8904889694');
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(Icons.phone,color: blue,),
                      ),
                      Text("Call Us")
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
