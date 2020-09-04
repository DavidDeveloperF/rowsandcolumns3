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
    List<Widget> columnNumbers = [];
    for(int x=0; x<=9; x++) {
      for(int y=0; y<=9; y++) {
        debugPrint("x/y = $x $y");    // ok this works
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
//            children: [Text("basic text2"),]
            children: myRowChildren,
        ));
  }
}
