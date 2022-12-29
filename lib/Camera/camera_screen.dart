import 'package:flutter/material.dart';
import 'package:fotobudka/Camera/capture_button.dart';
import 'package:fotobudka/Camera/countdown_preview.dart';
import 'package:fotobudka/Camera/settings_button.dart';
import 'package:fotobudka/Camera/settings_preview.dart';
import 'package:fotobudka/Camera/top_image_viewer.dart';
import 'camera_viewer.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        CameraViewer(),
        CaptureButton(),
        TopImageViewer(),
        SettingsButton(),
        SettingsPreview(),
        CountdownPreview()
      ],
    );
  }
}
