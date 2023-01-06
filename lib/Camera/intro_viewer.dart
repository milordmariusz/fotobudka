import 'package:flutter/material.dart';
import 'package:fotobudka/Camera/intro_first_page.dart';
import 'package:fotobudka/scan_controller.dart';
import 'package:get/get.dart';

class IntroViewer extends GetView<ScanController> {
  const IntroViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Container();
  }
}
