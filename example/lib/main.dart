import 'package:flutter/material.dart';
import 'package:risecx_range_of_motion/risecx_range_of_motion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  bool capturing = false;

  void _onCaptureHandler() {
    setState(() {
      capturing = !capturing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !capturing
          ? Center(child: Text('TAP TO CAPTURE'))
          : RisecxRangeOfMotion(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCaptureHandler,
        tooltip: 'Capture',
        child: Icon(!capturing ? Icons.camera : Icons.camera_outlined),
      ),
    );
  }
}
