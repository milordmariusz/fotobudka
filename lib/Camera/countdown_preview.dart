import 'package:flutter/material.dart';
import 'package:fotobudka/scan_controller.dart';
import 'package:get/get.dart';

class CountdownPreview extends GetView<ScanController> {
  const CountdownPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>Visibility(
      visible: controller.isTakingPhoto.value,
      child: Container(
        height: 150,
        width: 300,
        child: Center(
              child: Obx(() => Text('${controller.currentDelayTime.value}',
                  style: DefaultTextStyle.of(context).style.apply(
                      fontSizeFactor: 2,
                      color: Colors.white,
                      decoration: TextDecoration.none))),
        ),
      ),
    ));
  }
}
