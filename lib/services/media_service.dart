import 'dart:io';
import 'package:image_picker/image_picker.dart';


class MediaService {

  static MediaService instance = MediaService();

  MediaService() {}

  Future<File> getImageFromLibrary() async {
    XFile? _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(_xFile!.path);
  }

  Future<File> getImageFromCamera() async {
    XFile? _xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    return File(_xFile!.path);
  }

}
