import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late Future<CameraController> _cameraControllerFuture;
  late CameraDescription _currentCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraControllerFuture.then((cameraController) {
      cameraController.dispose();
    });
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _currentCamera = cameras[0]; // Set the initial camera to the back camera
    final cameraController =
    CameraController(_currentCamera, ResolutionPreset.medium);
    await cameraController.initialize();
    setState(() {
      _cameraControllerFuture = Future.value(cameraController);
    });
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();
    // Toggle the active camera
    _currentCamera = _currentCamera == cameras[0] ? cameras[1] : cameras[0];
    final cameraController =
    CameraController(_currentCamera, ResolutionPreset.medium);
    await cameraController.initialize();
    setState(() {
      _cameraControllerFuture = Future.value(cameraController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CameraController>(
        future: _cameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final cameraController = snapshot.data!;
            return Stack(
              children: [
                CameraPreview(cameraController),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: _switchCamera,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
