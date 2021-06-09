import 'package:VirtualLibrary/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

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
        title: new Text('About Virtual Library'),
      ),
      body: ListView(
        children:[ Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("About Books",style: heading,),
              ),
              Text("Good Books enriches our mind with good thoughts and knowledge just like a good friend. We cannot feel alone in the company of books. We can learn many good things while reading a good book. Books written by famous and experienced people helps us to become better human beings and also teach us how to serve society in the best possible way. When we are alone, we can always pick up a book and start reading to feel relaxed.",style: description,),
              Text("Books are our best friends because they inspire us to do great things in life and overcome our failures. We learn a lot from good books just like a good friend. Books can be good or bad, but it is our responsibility to choose them wisely. Friendship with Good books makes you a Good person and friendship with Bad books makes you a bad person. Books will always be there for you in your bad times. Books teach us to have dreams. Books bring positive value to our life.",style: description,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Virtual Library",style: heading,),
              ),
              Text("New tech, new perspective",style: subHeading,),
              Text(" Although often linked, anxiety about the new is different than nostalgia for the old.",style: description,),
              Text("A print book is a beautifully simple technology to use. Pick the thing up, turn each leaf in sequence until finished. If literate, anyone can pick up and read any print book.",style: description,),
              Text("An electronic book is a more complex technology. An eBook requires a computer, eReader or tablet, and a power source to keep the device charged. It requires computer access to a website or digital catalogue where files can be downloaded, and an understanding of how to use it.",style: description,),
              Text("Pages aren’t just turned, they are clicked and pinched and swiped – movements that need to be learned, and vary between different devices and brands.",style: description,),
              Text("In other words, you need new kinds of literacy to even get to the text. Moreover, you need to keep up with constant development and updating of these devices and programs, and understand the value and limitations of different devices, formats and suppliers.",style: description,),
              Text("This market-driven mess is the major issue with current eBooks. Different eReaders are made by different companies – Amazon’s Kindle, Barnes & Noble’s Nook and the Sony Reader, to name a few. Then there are tablets, such as Apple’s iPad, which perform a range of functions similar to a computer, one of which is enabling users to read eBooks through an app (short for “application”, or computer program).",style: description,),
              Text("These different devices run on different software, and require different file types. An eBook that works on a Kindle may not work on an iPad. There is no single file type that allows an eBook to be published on all devices.",style: description,),
              Text("So although cutting out the printing and binding process of traditional book production may seem to reduce production time and costs, the confusion of designing for different platforms and devices means an entirely new and more complicated production process has been introduced.",style: description,),
              Text("Urgency to capture the market means many of these devices and the software/programs on them are released before they have been properly tested, and have faults that need to be addressed by constantly updating to newer versions of the software.",style: description,),
              Text("Amazon’s Kindle Fire eReader, released just before Christmas 2011, was riddled with bugs and problems: volume-control glitches, an off-switch that was easily hit by accident, slow loading time and an unresponsive touch screen. Hundreds of articles and forums are dedicated to problems associated with iPads: overheating devices, Wi-Fi connectivity issues, slow charging, apps and eBooks refusing to sync or download.",style: description,),
              Text("This can seem overwhelming when you could just pick up a print book and begin reading immediately.",style: description,),
              Text("Yet the complexity of the digital system is what allows eBooks to do astounding things, and offers versatility and accessibility impossible in print.",style: description,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Access to information about all the books",style: heading,),
              ),
              Text("In the EnR virtual library, we offer free access to the information about all books in our database. This feature makes the user engage with any kind of books easily and access the information instantly. ",style: description,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Optimised Searching",style: heading,),
              ),
              Text("Searching for something is becoming difficult day by day due to the plenty of resources available in the digital world! The optimised search feature available in EnR library can bring an easy solution for this problem.",style: description,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Filtering books ",style: heading,),
              ),
              Text("Time is very essential in everyone’s life. Even saving a millisecond can have a bigger impact on the readers, is what we believe in. The flexibility we provide in the filter will help the reader save their time.",style: description,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Bookmarking.",style: heading,),
              ),
              Text("Bookmarking your favourite books helps the reader to keep the track of all his reading books. This feature in the EnR virtual library gives the reader easy accessibilities to his favourite books and create his own Virtual library.",style: description,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Backup",style: heading,),
              ),
              Text("The storage and backup of the books plays a key role for the users re-usability . This feature helps readers backup data and re-cover it anytime.",style: description,),
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
        ),
      ],
      ),
    );
  }
}
