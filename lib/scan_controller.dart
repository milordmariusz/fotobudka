import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotobudka/Camera/intro_first_page.dart';
import 'package:fotobudka/models/complete_banner.dart';
import 'package:fotobudka/models/data.dart';
import 'package:fotobudka/services/photo_service.dart';
import 'package:fotobudka/settings.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:drift/drift.dart' as d;
import 'package:intl/intl.dart';

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
  var delayTime = 4.obs;
  var selectedIndex = 0.obs;
  var currentDelayTime = 0.obs;
  var isTakingPhoto = false.obs;
  var context;
  late String _formatedDateTimeNow = "";

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

  Database? database;

  Future<void> initDatabase() async {
    database = Database();
    if ((await database?.getSettings())!.length == 0) {
      await database?.saveSettings(SettingsCompanion.insert(
        banerText: d.Value(banerTextController.text),
        banerIndex: d.Value(selectedIndex.value),
        delayTime: d.Value(delayTime.value),
        photosNumber: d.Value(photoNumber.value),
      ));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FirstIntroDialog();
        },
      );
    } else {
      banerTextController.text =
          (await database?.getSettings())![0]!.banerText!;
      selectedIndex.value = (await database?.getSettings())![0]!.banerIndex!;
      delayTime.value = (await database?.getSettings())![0]!.delayTime!;
      photoNumber.value = (await database?.getSettings())![0]!.photosNumber!;
    }
  }

  Future<void> updateDatabase() async {
    database?.UpdateDatabase(SettingsCompanion(
      banerText: d.Value(banerTextController.text),
      banerIndex: d.Value(selectedIndex.value),
      delayTime: d.Value(delayTime.value),
      photosNumber: d.Value(photoNumber.value),
    ));
  }

  @override
  void onInit() {
    initDatabase();
    initCamera();
    super.onInit();
  }

  void capture() {
    if (_cameraImage != null) {
      _imageList.clear();
      _imageList.refresh();
      currentPhotoNumber = photoNumber.value;
      _formatedDateTimeNow = getCurrentTime();
      captureFirstStage();
    }
  }

  void captureFirstStage() {
    currentDelayTime.value = delayTime.value;
    isTakingPhoto.value = true;
    captureSecondStage();
    PlaySound('assets/pop.mp3');
  }

  String getCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    return formatter.format(now);
  }

  void captureSecondStage() {
    Timer(const Duration(seconds: 1), () async {
      if (_isDelay()) {
        _playDelaySound();
        return;
      }

      Uint8List photo = _getCurrentPhoto();

      late Data data;
      if (!_isLastPhoto()) {
        _takePhoto();
        data = Data(_formatedDateTimeNow, base64Encode(photo), null, null);
      } else {
        CompleteBanner completeBanner = await _prepareDataToSend();
        data = Data(
          _formatedDateTimeNow,
          null,
          completeBanner.banner,
          completeBanner.text,
        );
      }

      await _photoService.sendPhoto(data);
    });
  }

  bool _isDelay() {
    return currentDelayTime.value != 0;
  }

  void _playDelaySound() {
    PlaySound('assets/pop.mp3');
    currentDelayTime.value -= 1;
    captureSecondStage();
  }

  Uint8List _getCurrentPhoto() {
    img.Image image = convertYUV420ToImage(_cameraImage);
    Uint8List photo = Uint8List.fromList(img.encodeJpg(image));
    _updateImageList(photo);
    return photo;
  }

  void _updateImageList(photo) {
    _imageList.add(photo);
    _imageList.refresh();
    currentPhotoNumber -= 1;
  }

  bool _isLastPhoto() {
    return currentPhotoNumber <= 0;
  }

  void _takePhoto() {
    PlaySound('assets/longpop.wav');
    Timer(const Duration(seconds: 1), () {
      captureFirstStage();
    });
  }

  Future<CompleteBanner> _prepareDataToSend() async {
    isTakingPhoto.value = false;
    PlaySound('assets/finishpop.wav');
    return _getCompleteBanner();
  }

  Future<CompleteBanner> _getCompleteBanner() async {
    return CompleteBanner(await _getBannerBase64(), banerTextController.text);
  }

  Future<String> _getBannerBase64() async {
    ByteData bytes = await rootBundle.load('assets/baner$selectedIndex.jpg');
    var buffer = bytes.buffer;
    var encodedBanner = base64.encode(Uint8List.view(buffer));
    return encodedBanner;
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
