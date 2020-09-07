import 'dart:ui' as ui;
import 'dart:typed_data'; // added by SDK
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // added by SDK

// #############################################################################
// ############################## D A TA #######################################
// #############################################################################
// #  Matrix 1  - descriptionMatrix (and it's columns - columnWidgets)
// #            - description of age colours and groups for the About page
// #  Matrix 2  - markerIconMatrix (the images in Uint8List format)
// #            - same layout as above, but without header & title rows
// #            - columnIcons are the columns within the markerIconMatrix
// #
// # class AnimalGroupSize  - TODO  ought to be in the database
// # animalGroupSizeList    - animal groups which should be read from the db
// #                        - includes the relevant image file name
// # ageBandMinutes         - TODO  ought to be in the database
// # ageBandColorlist       - TODO  ought to be in the database
// #                        - time bands: eg up to 240min = red (most current)
// #                        - Over final band also means due to be archived
// #############################################################################
// ######################## F U N C T I O N S ##################################
// #############################################################################
// # loadDescriptionMatrix(double matrixRowHeight, double matrixColWidth ) {
// #       populates the descriptionMatrix
// #       height and width parameters lets the calling routine adjust sizes
// #
// # loadIconMatrix - the Uint8List versions of the image files above
// #       This is a Future because the Uint8List getBytesFromAsset is async
// #
// # to assign a Sighting it's marker icon
// # x = lookupAgeBandColumn    - Loop through in descending order because we want the lowest column number
// # y = lookupAnimalGroupRow   - Loop through animalGroupSizeList and return the relevant row number
// #
// #   ageMinutesAsString -  format minutes to text as mins/hrs/days as appropriate
// #
// #############################################################################

// ## Matrices ################################################################# DATA
List<List<Widget>> descriptionMatrix = []; // matrix 1) as described below
List<Widget> columnWidgets = []; // populates the columns for 1)
List<List<Uint8List>> markerIconMatrix = []; // matrix 2) as described below
List<Uint8List> columnIcons = []; // populates the columns 2)

class AnimalGroupSize {
  String key; // eg 'Herd'
  String description; // what is this group size?
  String animalType; // what type of animal does it apply to
  String status; // is this current?
  String imageFileName; // new addition

  AnimalGroupSize(
      {this.key,
      this.description,
      this.animalType,
      this.status,
      this.imageFileName});
}

final List<AnimalGroupSize> animalGroupSizeList = <AnimalGroupSize>[
  AnimalGroupSize(
      key: "Herd (>9 deer)",
      description: "Group of 9 or more deer",
      animalType: "Deer",
      status: "Live",
      imageFileName: "herd"),
  AnimalGroupSize(
      key: "Small Group",
      description: "Group of 3-8 deer",
      animalType: "Deer",
      status: "Live",
      imageFileName: "small"),
  AnimalGroupSize(
      key: "Lone Deer",
      description: "individual deer",
      animalType: "Deer",
      status: "Live",
      imageFileName: "lone"),
  AnimalGroupSize(
      key: "Lone Stag",
      description: "individual male deer/stag",
      animalType: "Deer",
      status: "Live",
      imageFileName: "stag"),
  AnimalGroupSize(
      key: "Unknown",
      description: "group of deer (unknown number)",
      animalType: "Deer",
      status: "Live",
      imageFileName: "deer"),
  AnimalGroupSize(
      key: "Unconfirmed",
      description: "unconfirmed Sighting",
      animalType: "Deer",
      status: "Live",
      imageFileName: "outline"),
];


//  Original code: wherearethedeer version 0.6 and earlier
//final double ageinMinutes01 = 240.0;    //  4 hours   0.22a
//final double ageinMinutes02 = 720.0;    // 12 hours   0.22a
//final double ageinMinutes03 = 1440.0;   // 24 hours   0.22a
//final double ageinMinutes04 = 2880.0;   // 120 hours  0.22a
//final double ageinMinutes05 = 7200.0;   // 5x24 hours
final List<int> ageBandMinutes =        [240,    720, 1440, 2880, 7200];
final List<String> ageBandColorsList = [  "red","blue","brown","brown","grey"];
// Third item ought to be green, but don't actually have any green images

// ############################################################################# lookupAgeBandColumn
// #  lookupAgeBandColumn
// #  Loop through in descending order because we want the lowest column number
// #  default is last column number (ageBandMinutes.length -1)
// #############################################################################
int lookupAgeBandColumn(int itemAgeMinutes) {
  int columnIndex = ageBandMinutes.length - 1; // oldest = final column
  // ought to be archived if > final band
  for (int i = ageBandMinutes.length; i >= 0; i--) {
    if (itemAgeMinutes <= ageBandMinutes[i]) {
      columnIndex = i;
    }
    debugPrint(
        "item age (minutes) = $itemAgeMinutes column $columnIndex ${ageBandMinutes[i]}");
  }
  return columnIndex;
}

// ############################################################################# lookupAnimalGroupRow
// #  lookupAnimalGroupRow
// #  Loop through animalGroupSizeList and return the relevant row number
// #  default is last row number (animalGroupSizeList.length -1)
// #############################################################################
int lookupAnimalGroupRow(String animalGroupSize) {
  int rowIndex = animalGroupSizeList.length - 1; // final column = default

  for (int i = 0; i < animalGroupSizeList.length; i++) {
    if (animalGroupSize == animalGroupSizeList[i].key) {
      rowIndex = i;
    }
    debugPrint(
        "item groupSize = $animalGroupSize  Row= $rowIndex ${animalGroupSizeList[i].key}");
  }
  return rowIndex;
}

// #############################################################################
// # loadDescriptionMatrix(double matrixRowHeight, double matrixColWidth ) {
// # build TWO matrices:
// #  1) descriptionMatrix - descriptions and images by age band and groupsize
// #     =================
// #        AGEBAND       +red  +blue +green +brown +grey
// #   GROUPSIZE
// #   herd            herdred herdblue
// #   small
// #   lone
// #   stag
// #   unknown
// #   unconfirmed
// #
// #   UPDATE:  Had to separate these two matrix loads.
// #            The Uint8List conversion is a FUTURE & needs to be in async function
// #   2) markerIconMatrix - the Uint8List versions of the image files above
// #      ================
// #      built at the same time, without header or title column
// ############################################################################
void loadDescriptionMatrix(double matrixRowHeight, double matrixColWidth) {
  TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  //  index 0 - description, so <= matrix width [5 bands = 6 columns]           FOR Loop x
  for (int x = 0; x <= ageBandMinutes.length; x++) {
    columnWidgets = []; // empty the column   images or desriptions
//    columnIcons = [];   // empty the column   Uint8List

    //                                                                          FOR loop (y)
    for (int y = 0; y <= animalGroupSizeList.length; y++) {
      //                                                                        0,0 is the top left title
      if (x == 0) {
        if (y == 0) {
          columnWidgets.add(Container(
              height: matrixRowHeight,
              width: matrixColWidth,
              child: Text(
                "Up to: ",
                style: titleStyle,
              )));
          //                                                                    0,y is the animalGroupSize title (key)
        } else {
          columnWidgets.add(Container(
              height: matrixRowHeight,
              width: matrixColWidth * 1.7,
              child: Text(
                animalGroupSizeList[y - 1].key,
                style: titleStyle,
              )));
        }
      } else {
        //                                                                        x,0 is the top row - age
        if (y == 0) {
          columnWidgets.add(Container(
              height: matrixRowHeight / 2.0,
              width: matrixColWidth,
              child: Text(
                ageMinutesAsString(ageBandMinutes[x - 1]),
                style: titleStyle,
              )));
        } else {
          //                                                          x,y is the file name GROUP+COLOR
          //  for the main x,y items we need a file name
          //                            look up the filename
          //            y=animal group size                       x= aged color
          // todo This is where we should use the image lookup to load the icon
          String filenameAndPath = "images/" +
              animalGroupSizeList[y - 1].imageFileName +
              ageBandColorsList[x - 1] +
              ".png";
          columnWidgets.add(Container(
              height: matrixRowHeight,
              width: matrixColWidth,
              child: Image.asset(filenameAndPath)));
// todo as I suspected, can't put a Future here - need to figure out a way round this
//            debugPrint("want to run getBytesFromAsset($filenameAndPath, 100) for (${x-1},${y-1})");
//          columnIcons.add(
//              getBytesFromAsset(filenameAndPath, 100)    // can't have Future<Uint8List> ?????
//          );
        } // end of else (x,y) where x>0 and y>0
      } // end of else x>0

    } // end of y loop (rows)   end of y loop (rows)      end of y loop (rows)  end of y loop (rows)
    descriptionMatrix.add(columnWidgets);
//    markerIconMatrix.add(columnIcons);
  } // end of x loop (columns)         // end of x loop (columns)            // end of x loop (columns)
}

// #############################################################################
// #   2) markerIconMatrix - the Uint8List versions of the image files above
// #      ================
// #############################################################################
Future<void> loadIconMatrix() async {
  //  Note that THIS version does not have the header row or title column
  //       so it cycles from 0 to less than List length (not <= as above)
  //                                                                            FOR loop (x)
  for (int x = 0; x < ageBandMinutes.length; x++) {

    columnIcons = []; // empty the column   Uint8List

    //                                                                          FOR loop (y)
    for (int y = 0; y < animalGroupSizeList.length; y++) {
      //  for the main x,y items we need a file name
      //                            look up the filename
      //            y=animal group size                       x= aged color
      String filenameAndPath = "images/" +
          animalGroupSizeList[y].imageFileName +
          ageBandColorsList[x] +
          ".png";
      Uint8List _tempIcon = await getBytesFromAsset(filenameAndPath, 100);
      columnIcons.add( _tempIcon   );

    } // end of y loop (rows)   end of y loop (rows)      end of y loop (rows)  end of y loop (rows)
    markerIconMatrix.add(columnIcons);
  } // end of x loop (columns)         // end of x loop (columns)            // end of x loop (columns)
}

// ############################################################################
// #   getBytesFromAsset
// #   looks up an image file and converts to Uint8List (for map marker icons)
// ############################################################################
Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();

//  debugPrint ("** getBytesFromAsset $path");

  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

// ############################################################################
// #   ageMinutesAsString
// #   format minutes to text as mins/hrs/days as appropriate
// ############################################################################
String ageMinutesAsString(int ageMinutes) {
  String ageAsString;

  //                                       up to 120 min / 2 hours - show age in minutes
  if (ageMinutes < 120) {
    ageAsString = ageMinutes.toStringAsFixed(0) + " mins";
  } else {
    //                                     up to 1200 min / 20 hours - show age in hours
    if (ageMinutes < 1200) {
      ageAsString = (ageMinutes / 60).toStringAsFixed(0) + " hrs";
    } else {
      //                                    Otherwise - show age in days         days
      ageAsString = (ageMinutes / 60 / 24).toStringAsFixed(0) + " days";
    }
  }
  return ageAsString;
}

// #################################################################################
// ############ ORIGINAL CODE FROM WATD 0.60########################################
// #################################################################################
// ## It used a flat matrix and long set of switch statements to lookup images #####
// #################################################################################
// OK we'll build a table of markers
List<Uint8List> markerIconList = new List<Uint8List>();

//List <String> markerIconAssets = [
//  "images/deer_16.png",       // unknown/default            item 0
//  "images/herdred_24.png",    // current icons red 1-4
//  "images/lonered_24.png",
//  "images/smallred_24.png",
//  "images/stagred_24.png",
//  "images/herdblue_24.png",   // older icons blue 5-8
//  "images/loneblue_24.png",
//  "images/smallblue_24.png",
//  "images/stagblue_24.png",
//  "images/herdbrown_24.png",  // even older brown 9-12
//  "images/lonebrown_24.png",
//  "images/smallbrown_24.png",
//  "images/stagbrown_24.png",
//  "images/herdgrey_16.png",   // very old icons grey (and smaller) 13-16
//  "images/lonegrey_16.png",
//  "images/smallgrey_16.png",
//  "images/staggrey_16.png",
//  "images/deerblue_24.png",   // spare for future use    17-20
//  "images/deerblue_24.png",   // spare for future use    17-20
//  "images/deerblue_24.png",   // spare for future use    17-20
//  "images/deerblue_24.png",   // spare for future use    17-20
//  "images/coffee_cup.png",    // coffee cup = cafe        #21
//  "images/information.png",   // visitor information      #22
//  "images/wc_sign.png",       // toilets                  #23
//  "images/outline_deer_red_24.png",     // Not current Sightings    #24
//  "images/outline_deer_blue_24.png",    // Not current Sightings    #25
//  "images/outline_deer_brown_24.png",   // Not current Sightings    #26
//  "images/outline_deer_grey_16.png",    // Not current Sightings    #27
//  "images/outline_deer_grey_16.png",    // Not current Sightings    #28
//  ];
