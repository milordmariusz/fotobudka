import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotobudka/models/data.dart';
import 'package:fotobudka/services/photo_service.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController {
  final TextEditingController banerTextController = TextEditingController();
  final AudioPlayer player = AudioPlayer();
  final RxBool _isInitialized = RxBool(false);
  final RxList<Uint8List> _imageList = RxList([]);
  final PhotoService _photoService = PhotoService();
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  CameraImage? _cameraImage;
  var currentPhotoNumber = 0;
  var photoNumber = 4.obs;
  var delayTime = 5.obs;
  var selectedIndex = 0.obs;
  var currentDelayTime = 0.obs;
  var isTakingPhoto = false.obs;

  CameraController get cameraController => _cameraController;

  bool get isInitialized => _isInitialized.value;

  List<Uint8List> get imageList => _imageList;

  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.bgra8888);
    _cameraController.initialize().then((value) {
      _isInitialized.value = true;
      _cameraController.startImageStream((image) => _cameraImage = image);

      _isInitialized.refresh();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void onInit() {
    initCamera();
    super.onInit();
  }

  void capture() {
    if (_cameraImage != null) {
      currentPhotoNumber = photoNumber.value;
      captureFirstStage();
    }
  }

  void captureFirstStage() {
    currentDelayTime.value = delayTime.value;
    isTakingPhoto.value = true;
    captureSecondStage();
    // PlaySound('assets/pop.mp3');
  }

  void captureSecondStage() {
    Timer(Duration(seconds: 1), () {
      if (currentDelayTime.value != 0) {
        // PlaySound('assets/pop.mp3');
        captureSecondStage();
        currentDelayTime.value -= 1;
      } else {
        img.Image image = img.Image.fromBytes(_cameraImage!.width,
            _cameraImage!.height, _cameraImage!.planes[0].bytes,
            format: img.Format.bgra);
        Uint8List list = Uint8List.fromList(img.encodeJpg(image));
        _imageList.add(list);
        var data = Data(base64Encode(list), null, null);
        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
        print(data.toString());
        print(data.photo);
        _photoService.sendPhoto(data);
        _imageList.refresh();
        currentPhotoNumber -= 1;
        if (currentPhotoNumber > 0) {
          // PlaySound('assets/longpop.wav');
          Timer(Duration(seconds: 1), () {
            //ZROBIENIE 1 ZDJECIA
            captureFirstStage();
          });
        } else {
          //KONIEC WSZYSTKICH ZDJEC
          isTakingPhoto.value = false;
          // PlaySound('assets/finishpop.wav');
        }
      }
    });
  }

  Future<void> PlaySound(string) async {
    String audioasset = string;
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
  }
}
