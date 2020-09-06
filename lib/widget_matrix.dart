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
  double matrixRowHeight = 30.0;
  double matrixColWidth = 50.0;
  double matrixSizeScale = 0.95;

  // col  1 = description
  // cols 2 = images by age band...
  //        first item in each col (i.e top row) should be a heading/title

  @override
  Widget build(BuildContext context) {

  loadIconAndDescriptionMatrix();


    //  so this widget list displays rows which are each made of columns of widgets
    myRowColumnWidgets = descriptionMatrix
        .map(
          // map the numberList to a Column
          (columns) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
        title: Text("Widget Matrix"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
//        height: 560,
//        width: 480,
            children: <Widget>[
//            Image.asset("lib/images/lonegrey.png"),
              Transform.scale(
                scale: matrixSizeScale,     // 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: myRowColumnWidgets,
                ),
              ),
            ]),
      ),

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

// #############################################################################
// # loadIconAndDescriptionMatrix(double matrixRowHeight, double matrixColWidth ) {
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
// #   2) markerIconMatrix - the Uint8List versions of the image files above
// #      ================
// #      built at the same time, without header or title column
// ############################################################################
void loadIconAndDescriptionMatrix(double matrixRowHeight, double matrixColWidth ) {
  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,);
  List<List<Widget>> descriptionMatrix = [];    // matrix 1) as described above
  List<Widget>       columnWidgets = [];        // populates the columns above
  List<List<Uint8List>> markerIconMatrix = [];  // matrix 2) as described above
  List<Uint8List>    columnIcons = [];          // populates the columns above


  //  index 0 - description, so <= matrix width [5 bands = 6 columns]           FOR Loop x
  for (int x = 0; x <= ageBandMinutes.length; x++) {

    columnWidgets = []; // empty the column   images or desriptions
    columnIcons = [];   // empty the column   Uint8List

    //                                                                          FOR loop (y)
    for (int y = 0; y <= animalGroupSizeList.length; y++) {

      //                                                                        0,0 is the top left title
      if (x == 0) {
        if (y == 0) {
          columnWidgets.add(
              Container(height: matrixRowHeight, width: matrixColWidth, child:
              Text("Up to: ", style: titleStyle,)
              ));
          //                                                                    0,y is the animalGroupSize title (key)
        } else {
          columnWidgets.add(
              Container(height: matrixRowHeight, width: matrixColWidth*1.7, child:
              Text(animalGroupSizeList[y - 1].key,style: titleStyle,)
              ));
        }
      } else {
        //                                                                        x,0 is the top row - age
        if (y == 0) {
          columnWidgets.add(
              Container(height: matrixRowHeight/2.0, width: matrixColWidth, child:
              Text(ageMinutesAsString(ageBandMinutes[x - 1]), style: titleStyle,)
              ));
        } else {    //                                                          x,y is the file name GROUP+COLOR
          //  for the main x,y items we need a file name
          //                            look up the filename
          //            y=animal group size                       x= aged color
          // todo This is where we should use the image lookup to load the icon
          String filenameAndPath = "images/" +
              animalGroupSizeList[y - 1].imageFileName +
              ageBandColorsList[x - 1] +
              ".png" ;
          columnWidgets.add(
              Container(height: matrixRowHeight, width: matrixColWidth, child:
              Image.asset(filenameAndPath)
              ));
          columnIcons.add(
            getBytesFromAsset(filenameAndPath, 100)
          );
        }
      }

    } // end of y loop (rows)   end of y loop (rows)      end of y loop (rows)  end of y loop (rows)
    descriptionMatrix.add(columnWidgets);
    markerIconMatrix.add(columnIcons);
  } // end of x loop (columns)         // end of x loop (columns)            // end of x loop (columns)

}
