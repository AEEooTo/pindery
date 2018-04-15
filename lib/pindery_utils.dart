/// Class for some Android utils

import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PinderyUtils {
  static Future<File> pickImage(ImageSource source) async {
    File imageFile = await ImagePicker.pickImage(source: source);
    return imageFile;
  }
}