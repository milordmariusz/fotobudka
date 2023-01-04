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
        imageFormatGroup: ImageFormatGroup.yuv420);
    _cameraController.initialize().then((value) {
      _isInitialized.value = true;
      _cameraController.lockCaptureOrientation(DeviceOrientation.portraitUp);
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
      _imageList.clear();
      _imageList.refresh();
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
        img.Image image = convertYUV420ToImage(_cameraImage);
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

  static img.Image convertYUV420ToImage(CameraImage? cameraImage) {
    final width = cameraImage?.width;
    final height = cameraImage?.height;

    final yRowStride = cameraImage?.planes[0].bytesPerRow;
    final uvRowStride = cameraImage?.planes[1].bytesPerRow;
    final uvPixelStride = cameraImage?.planes[1].bytesPerPixel!;

    final image = img.Image(width!, height!);

    for (var w = 0; w < width; w++) {
      for (var h = 0; h < height; h++) {
        final uvIndex =
            uvPixelStride! * (w / 2).floor() + uvRowStride! * (h / 2).floor();
        final index = h * width + w;
        final yIndex = h * yRowStride! + w;

        final y = cameraImage?.planes[0].bytes[yIndex];
        final u = cameraImage?.planes[1].bytes[uvIndex];
        final v = cameraImage?.planes[2].bytes[uvIndex];

        image.data[index] = yuv2rgb(y!, u!, v!);
      }
    }
    return image;
  }

  static int yuv2rgb(int y, int u, int v) {
    // Convert yuv pixel to rgb
    var r = (y + v * 1436 / 1024 - 179).round();
    var g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    var b = (y + u * 1814 / 1024 - 227).round();

    // Clipping RGB values to be inside boundaries [ 0 , 255 ]
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
    ((b << 16) & 0xff0000) |
    ((g << 8) & 0xff00) |
    (r & 0xff);
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
