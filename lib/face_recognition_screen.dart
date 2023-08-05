import 'package:flutter/material.dart';
import 'camera_view.dart';

class FaceRecognitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Recognition'),
      ),
      body: CameraView(),
    );
  }
}
