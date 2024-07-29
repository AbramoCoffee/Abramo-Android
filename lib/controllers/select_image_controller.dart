import 'dart:developer';

import 'package:abramo_coffee/resources/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageController extends GetxController {
  RxString path = 'Pilih'.obs;
  RxString result = ''.obs;
  final ImagePicker _imagePicker = ImagePicker();
  final _box = GetStorage();
  RxList<String> images = <String>[].obs;

  Future selectImage() async {
    try {
      XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 720,
        maxHeight: 1280,
        imageQuality: 70,
      );
      path.value = imageFile!.path;
      log("image path ${path.value}");
      _box.write(currentPathImg, path.value);
      return path.value;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future selectImageCamera() async {
    try {
      XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 720,
        maxHeight: 1280,
        imageQuality: 50,
      );
      if (imageFile != null) {
        // path.value = imageFile.path.toString();

        path.value = imageFile.path;

        // result.value = imageFile.path;
        images.add(path.value);
      }
      // images.add(File(path.value));
      // _box.write(currentPathImg, images.value);
    } catch (e) {
      throw Exception(e);
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
  }
}
