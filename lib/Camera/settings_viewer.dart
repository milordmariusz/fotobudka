import 'package:flutter/material.dart';
import 'package:fotobudka/scan_controller.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsViewer extends GetView<ScanController> {
  const SettingsViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .80,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                  ),
                ],
              ),
              Row(children: const <Widget>[SizedBox(height: 10)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Ilosc zdjęć',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => NumberPicker(
                      minValue: 2,
                      maxValue: 8,
                      value: controller.photoNumber.value,
                      onChanged: (value) {
                        controller.photoNumber.value = value;
                        controller.updateDatabase();
                      },
                      selectedTextStyle: const TextStyle(
                          fontSize: 30, color: Colors.deepPurpleAccent),
                      axis: Axis.horizontal,
                    ),
                  ),
                ],
              ),
              Row(children: const <Widget>[SizedBox(height: 10)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Czas pomiędzy zdjęciami',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => NumberPicker(
                        minValue: 1,
                        maxValue: 10,
                        value: controller.delayTime.value,
                        onChanged: (value) {
                          controller.delayTime.value = value;
                          controller.updateDatabase();
                        },
                        selectedTextStyle: const TextStyle(
                            fontSize: 30, color: Colors.deepPurpleAccent),
                        axis: Axis.horizontal,
                      )),
                ],
              ),
              Row(children: const <Widget>[SizedBox(height: 10)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Baner',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Row(children: const <Widget>[SizedBox(height: 00)]),
              TextFormField(
                onChanged: (value) {
                  controller.updateDatabase();
                },
                maxLength: 26,
                controller: controller.banerTextController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Wpisz tekst na banerze',
                ),
              ),
              Row(children: const <Widget>[SizedBox(height: 20)]),
              SizedBox(
                height: 256,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemBuilder: (context, index) {
                    return Obx(
                      () => InkWell(
                        onTap: () => {
                          controller.selectedIndex.value = index,
                          controller.updateDatabase()
                        },
                        child: buildCard(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(int index) => Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: controller.selectedIndex.value == index ? 10 : 0,
              color: Colors.deepPurpleAccent),
        ),
        width: 128,
        height: 256,
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/baner${index}.jpg',
                repeat: ImageRepeat.repeat,
              ),
            ),
            Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  controller.banerTextController.text,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
}
