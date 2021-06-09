import 'package:firebase_storage/firebase_storage.dart';


Future loadFromStorage(String image) async {
  StorageReference ref = FirebaseStorage.instance.ref().child(image);
  String url = (await ref.getDownloadURL()).toString();
  return url;
}

Future loadCategoryImages({List categoryList}) async{
  List categoryURLs=[];
  for(String temp in categoryList)
    categoryURLs.add(await loadFromStorage("Category Logos/$temp.jpg"));
  return categoryURLs;
}

Future loadBanner() async{
  List bannerURLs=[];
  for(int i=1;i<5;i++)
    bannerURLs.add(await loadFromStorage("banners/banner-$i.jpg"));
  return bannerURLs;
}

Future loadAdvertisement() async{
  List advertisementURLs=[];
  for(int i=1;i<3;i++)
    advertisementURLs.add(await loadFromStorage("advertisement/advertisement-$i.jpg"));
  return advertisementURLs;
}

Future loadAvatar(int age,int gender) async{
  String name,value;
  if(age<10)
    name="kid";
  else if(age<20)
    name="teen";
  else if(age<50)
    name="adult";
  else
    name="oladage";
  if(gender==1)
    value="1";
  else
    value="2";
   String url=await loadFromStorage("avatars/$name$value.jpg");
  return url;
}