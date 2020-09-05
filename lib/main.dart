import 'package:flutter/material.dart';

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
    List<Color> manyColors = [Colors.red, Colors.green, Colors.blue];
    List<Widget> myRowChildren = [];
    List<List<int>> numbersList = [];
    List<int> columnNumbersList = [];
    int maxRows = 10;
    int maxColumnNumbers = 10;
    int z = 0;
    int myCounter = 0;

    for (int x = 0; x < maxRows; x++) {
      // rows 0-9 (10 of them)
      for (int y = 0; y < maxColumnNumbers; y++) {
        int currentNumber = y + z; // 0,1,2,3,4,5,6,7,8,9,10  11,12,13,etc
        columnNumbersList.add(currentNumber);

        myCounter++;
        debugPrint("x/y = ($x,$y) and currentNumber= $currentNumber"
            " myCounter=$myCounter"); // ok this works
      }
      z += maxColumnNumbers; // z is counting rows in 10's Actually 11?
      numbersList.add(columnNumbersList); // add col numbers to the row
      columnNumbersList = []; // empty the column
    }

    myRowChildren = numbersList
        .map(
          (columns) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: columns
                .map((number) => Container(child: Text(number.toString())))
                .toList(),
          ),
        )
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
//            children: [Text("basic text2"),]
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: myRowChildren,
        ));
  }
}
