import 'dart:ui' as ui;
import 'dart:typed_data';                     // added by SDK
import 'package:flutter/services.dart';       // added by SDK

class AnimalGroupSize {
  String key;               // eg 'Herd'
  String description;       // what is this group size?
  String animalType;        // what type of animal does it apply to
  String status;            // is this current?
  String imageFileName;      // new addition

  AnimalGroupSize({
    this.key,
    this.description,
    this.animalType,
    this.status,
    this.imageFileName
  });
}
final List<AnimalGroupSize> animalGroupSizeList = <AnimalGroupSize> [
AnimalGroupSize(key: "Herd (>9 deer)", description: "Group of 9 or more deer", animalType: "Deer", status: "Live", imageFileName: "herd"),
AnimalGroupSize(key: "Small Group", description: "Group of 3-8 deer", animalType: "Deer", status: "Live", imageFileName: "small"),
AnimalGroupSize(key: "Lone Deer", description: "individual deer", animalType: "Deer",  status: "Live", imageFileName: "lone"),
AnimalGroupSize(key: "Lone Stag", description: "individual male deer/stag", animalType: "Deer", status: "Live", imageFileName: "stag"),
AnimalGroupSize(key: "Unknown", description: "group of deer (unknown number)", animalType: "Deer", status: "Live", imageFileName: "deer"),
AnimalGroupSize(key: "Unconfirmed", description: "unconfirmed Sighting", animalType: "Deer", status: "Live", imageFileName: "outline"),
];

final List<String> ageBandColorsList =[
  "red",
  "blue",
  "green",
  "brown",
  "grey"
];
//final double ageinMinutes01 = 300.0;    //  5 hours   0.22a
//final double ageinMinutes02 = 720.0;    // 12 hours   0.22a
//final double ageinMinutes03 = 1440.0;   // 24 hours   0.22a
//final double ageinMinutes04 = 2880.0;   // 120 hours  0.22a
//final double ageinMinutes05 = 7200.0;   // 5x24 hours
final List<int> ageBandMinutes =[300, 720, 1440,2880,7200];


// OK we'll build a table of markers
List <Uint8List> markerIconList = new List<Uint8List>();

List <String> markerIconAssets = [
  "images/deer_16.png",       // unknown/default            item 0
  "images/herdred_24.png",    // current icons red 1-4
  "images/lonered_24.png",
  "images/smallred_24.png",
  "images/stagred_24.png",
  "images/herdblue_24.png",   // older icons blue 5-8
  "images/loneblue_24.png",
  "images/smallblue_24.png",
  "images/stagblue_24.png",
  "images/herdbrown_24.png",  // even older brown 9-12
  "images/lonebrown_24.png",
  "images/smallbrown_24.png",
  "images/stagbrown_24.png",
  "images/herdgrey_16.png",   // very old icons grey (and smaller) 13-16
  "images/lonegrey_16.png",
  "images/smallgrey_16.png",
  "images/staggrey_16.png",
  "images/deerblue_24.png",   // spare for future use    17-20
  "images/deerblue_24.png",   // spare for future use    17-20
  "images/deerblue_24.png",   // spare for future use    17-20
  "images/deerblue_24.png",   // spare for future use    17-20
  "images/coffee_cup.png",    // coffee cup = cafe        #21
  "images/information.png",   // visitor information      #22
  "images/wc_sign.png",       // toilets                  #23
  "images/outline_deer_red_24.png",     // Not current Sightings    #24
  "images/outline_deer_blue_24.png",    // Not current Sightings    #25
  "images/outline_deer_brown_24.png",   // Not current Sightings    #26
  "images/outline_deer_grey_16.png",    // Not current Sightings    #27
  "images/outline_deer_grey_16.png",    // Not current Sightings    #28
  ];



Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();

//  debugPrint ("** getBytesFromAsset $path");

  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}

// ############################################################################
// #   ageMinutesAsString
// #   format minutes to text as mins/hrs/days as appropriate
// ############################################################################
String ageMinutesAsString (int ageMinutes) {
  String ageAsString;

  //                                       up to 120 min / 2 hours - show age in minutes
  if (ageMinutes < 120) {
    ageAsString = ageMinutes.toStringAsFixed(0) + " mins";
  } else {
    //                                     up to 1200 min / 20 hours - show age in hours
    if (ageMinutes < 1200) {
      ageAsString =
          (ageMinutes / 60).toStringAsFixed(0) +  " hrs";
    } else {
      //                                    Otherwise - show age in days         days
      ageAsString = (ageMinutes / 60 / 24).toStringAsFixed(1) + " days";
    }
  }
  return ageAsString;
}
