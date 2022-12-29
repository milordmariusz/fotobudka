import 'package:flutter/material.dart';
import 'package:fotobudka/scan_controller.dart';
import 'package:get/get.dart';

class SettingsViewer extends GetView<ScanController> {
  const SettingsViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .80,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text("Ustawienia", style: TextStyle(fontSize: 30)),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "XD",
                  style: TextStyle(fontSize: 30, color: Colors.green[900]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
