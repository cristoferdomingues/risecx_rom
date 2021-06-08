import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:risecx_range_of_motion/widgets/bndbox_widget.dart';
import 'package:risecx_range_of_motion/widgets/camera_widget.dart';
import 'package:risecx_range_of_motion/widgets/sticker.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<CameraDescription> cameras = <CameraDescription>[];
  List<dynamic> _recognitions = <dynamic>[];
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    try {
      String? res = await Tflite.loadModel(
          model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite");
      print(res);
      cameras = await availableCameras();
      setState(() {
        loaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: !this.loaded
          ? Center(
              child: Text('Loading...'),
            )
          : Stack(
              children: [
                Camera(
                  cameras: cameras,
                  setRecognitions: setRecognitions,
                ),
                RenderData(
                    data: _recognitions,
                    previewH: math.max(_imageHeight, _imageWidth),
                    previewW: math.min(_imageHeight, _imageWidth),
                    screenH: screen.height,
                    screenW: screen.width),
              ],
            ),
    );
  }
}
