import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController {
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  final RxBool _isInitialized = RxBool(false);
  CameraImage? _cameraImage;
  final RxList<Uint8List> _imageList = RxList([]);

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
      currentPhotoNumber.value = photoNumber.value;
      captureFirstStage();
    }
  }

  void captureFirstStage() {
    currentDelayTime.value = delayTime.value;
    isTakingPhoto.value = true;
    captureSecondStage();
  }

  void captureSecondStage() {
    Timer(Duration(seconds: 1), () {
      if (currentDelayTime.value != 0) {
        captureSecondStage();
        currentDelayTime.value -= 1;
      } else {
        img.Image image = img.Image.fromBytes(_cameraImage!.width,
            _cameraImage!.height, _cameraImage!.planes[0].bytes,
            format: img.Format.bgra);
        Uint8List list = Uint8List.fromList(img.encodeJpg(image));
        _imageList.add(list);
        _imageList.refresh();
        currentPhotoNumber.value -= 1;
        if (currentPhotoNumber.value > 0) {
          Timer(Duration(seconds: 1), () {
            captureFirstStage();
          });
        } else {
          isTakingPhoto.value = false;
        }
      }
    });
  }

  var photoNumber = 4.obs;
  var currentPhotoNumber = 0.obs;
  var delayTime = 5.obs;
  var selectedIndex = 0.obs;
  var currentDelayTime = 0.obs;
  var isTakingPhoto = false.obs;
}
