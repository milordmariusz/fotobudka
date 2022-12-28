import 'package:flutter/material.dart';
import 'package:fotobudka/Camera/camera_screen.dart';
import 'package:get/get.dart';

import 'global_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CameraScreen(),
      title: "Fotobudka",
      initialBinding: GlobalBindings(),
    );
  }
}
