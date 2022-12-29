import 'package:flutter/material.dart';
import 'package:fotobudka/Camera/settings_viewer.dart';
import 'package:fotobudka/scan_controller.dart';
import 'package:get/get.dart';

class SettingsButton extends GetView<ScanController> {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 45,
        left: 50,
        child: GestureDetector(
          onTap: () => _ShowSettingsViewer(context),
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Center(
              child: Icon(
                Icons.settings,
                size: 40,
              ),
            ),
          ),
        ));
  }

  void _ShowSettingsViewer(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return SettingsViewer();
      },
    );
  }
}
