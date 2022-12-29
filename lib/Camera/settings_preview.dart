import 'package:flutter/material.dart';
import 'package:fotobudka/scan_controller.dart';
import 'package:get/get.dart';

class SettingsPreview extends GetView<ScanController> {
  const SettingsPreview({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 35,
      child: Container(
          height: 80,
          width: 80,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('1x',
                    style: DefaultTextStyle.of(context).style.apply(
                        fontSizeFactor: 0.5,
                        color: Colors.white,
                        decoration: TextDecoration.none)),
                Text('1s',
                    style: DefaultTextStyle.of(context).style.apply(
                        fontSizeFactor: 0.5,
                        color: Colors.white,
                        decoration: TextDecoration.none)),
              ],
            ),
          )),
    );
  }
}
