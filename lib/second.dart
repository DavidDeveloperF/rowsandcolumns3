import 'package:flutter/material.dart';
import 'package:rowsandcolumns/main.dart';

import 'image_code.dart';

// ############################################################################# second page
// # my attempt to do this myself
// ############################################################################
class SecondPageMenu extends StatefulWidget {
  @override
  _SecondPageMenuState createState() => _SecondPageMenuState();
}

class _SecondPageMenuState extends State<SecondPageMenu> {
  List<Widget> myRowColumnWidgets = [];
  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,);
  // col  1 = description
  // cols 2 = images by age band...
  //        first item in each col (i.e top row) should be a heading/title

  @override
  Widget build(BuildContext context) {
    //        AGEBAND       +red  +blue +green +brown +grey
//    GROUPSIZE
//    herd            herdred herdblue
//    small
//    lone
//    stag
//    unknown
//    unconfirmed



    List<List<Widget>> matrixList = [];
    List<Widget> columnWidgets = [];

    //  index 0 - description, so <= matrix width [5 bands = 6 columns]
    for (int x = 0; x <= ageBandMinutes.length; x++) {

      columnWidgets = []; // empty the column

      //                                          first row/col is description
      for (int y = 0; y <= animalGroupSizeList.length; y++) {
        //                                        0,0 is the top left title
        if (x == 0) {
          if (y == 0) {
            columnWidgets.add(Text("Up to: ", style: titleStyle,));
            //                                    0,y is the animalGroupSize title (key)
          } else {
            columnWidgets.add(Text(animalGroupSizeList[y - 1].key, style: titleStyle,));
          }
        } else {
        //                                        x,0 is the top row - age
          if (y == 0) {
            columnWidgets.add(Text(ageMinutesAsString(ageBandMinutes[x - 1]), style: titleStyle,));
          } else {
        //  for the main x,y items we need a file name
            //                            look up the filename
            //            y=animal group size                       x= aged color
            // todo This is where we should use the image lookup to load the icon
            String filenameAndPath = "images/" +
                animalGroupSizeList[y - 1].imageFileName +
                ageBandColorsList[x - 1] +
                ".png";
            debugPrint(filenameAndPath + " ($x,$y)");
            columnWidgets.add(Text(
                "${animalGroupSizeList[y - 1].imageFileName}${ageBandColorsList[x - 1]}"));
          }
        }
      } // end of y loop (rows)
//      debugPrint("End of y loop" + columnWidgets.toString());
      matrixList.add(columnWidgets);
    } // end of x loop (columns)

    debugPrint("matrixList= " + matrixList.toString());

    //  so this widget list displays rows which are each made of columns of widgets
    myRowColumnWidgets = matrixList
        .map(
          // map the numberList to a Column
          (columns) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: columns             // map the actual item to a Container
                .map((item) {
              return Container(
                  padding: EdgeInsets.all(1),
                  child: item
              );
            }).toList(), // this .toList make the column
          ),
        )
        .toList(); // this .toList sits inside the Row below

    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page (images)"),
      ),

      body: Column(
//        height: 560,
//        width: 480,
          children: <Widget>[
            Transform.scale(
              scale: 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: myRowColumnWidgets,
              ),
            ),
          ]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
        tooltip: "Back",
        child: Icon(Icons.backspace),
      ),
    );
  }
}
