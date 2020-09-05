import 'package:flutter/material.dart';
import 'package:rowsandcolumns/image_code.dart';

import 'second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Color> manyColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.grey,
      Colors.yellowAccent,
      Colors.pinkAccent
    ];
    List<Widget> myRowChildren = [];
    List<List<int>> numbersList = [];
    List<int> columnNumbersList = [];
    int maxRows = 6; // not number of rows!    It's # of columns in each row
    // x axis = left to right
    int maxColumnNumbers = 5; // not number of Columns! It's # of rows!!
    // y axis = up/down
    int z = 0;
//    int myCounter = 0;

    for (int x = 0; x < maxRows; x++) {
      // rows 0-9 (10 of them)
      for (int y = 0; y < maxColumnNumbers; y++) {
        int currentNumber = y + z; // 0,1,2,3,4,5,6,7,8,9,10  11,12,13,etc
        columnNumbersList.add(currentNumber);
//        myCounter++;
//        debugPrint("x/y = ($x,$y) and currentNumber= $currentNumber"
//            " myCounter=$myCounter"); // ok this works
      }
      z += maxColumnNumbers; // z is counting rows in 10's Actually 11?
      numbersList.add(columnNumbersList); // add col numbers to the row
      columnNumbersList = []; // empty the column
    }
//  so this widget list displays rows which are each made of columns of numbers
    myRowChildren = numbersList
        .map(
          // map the numberList to a Column
          (columns) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: columns // map the actual number to a Text
                .map((number) {
// TODO add i randomising code here to pick a color
              return Container(
                  padding: EdgeInsets.all(10),
                  color: manyColors[2],
                  child: Text(number.toString()));
            }).toList(), // this .toList make the column
          ),
        )
        .toList(); // this .toList sits inside the Row below

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
//            children: [Text("basic text2"),]
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: myRowChildren,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SecondPageMenu()));
        },
        tooltip: "Page 2",
        child: Icon(Icons.no_sim),
      ),
    );
  }
}

