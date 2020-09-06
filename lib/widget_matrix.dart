import 'package:flutter/material.dart';
import 'package:rowsandcolumns/main.dart';

import 'image_code.dart';

// ############################################################################# second page
// # my attempt to do this myself
// ############################################################################
class DisplayDescriptionMatrix extends StatefulWidget {
  @override
  _DisplayDescriptionMatrixState createState() => _DisplayDescriptionMatrixState();
}

class _DisplayDescriptionMatrixState extends State<DisplayDescriptionMatrix> {
  List<Widget> myRowColumnWidgets = [];
  double matrixRowHeight = 30.0;
  double matrixColWidth = 50.0;
  double matrixSizeScale = 0.95;

  @override
  Widget build(BuildContext context) {

// # loadIconAndDescriptionMatrix(double matrixRowHeight, double matrixColWidth ) {
// # build TWO matrices:
// #  1) descriptionMatrix - descriptions and images by age band and groupsize
// #  2) markerIconMatrix - the Uint8List versions of the image files
    loadIconAndDescriptionMatrix(matrixRowHeight, matrixColWidth);

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

