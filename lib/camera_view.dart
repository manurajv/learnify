import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late Future<CameraController> _cameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    _cameraControllerFuture.then((cameraController) {
      cameraController.dispose();
    });
    super.dispose();
  }

  Future<CameraController> _initializeCamera() async {
    final cameras = await availableCameras();
    final cameraController =
    CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize();
    return cameraController;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CameraController>(
      future: _cameraControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final cameraController = snapshot.data!;
          return CameraPreview(cameraController);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
