///here is managed the image compression
///

library image_compression;

//Dart core imports
import 'dart:io';
import 'dart:async';
import 'dart:math';

//External libraries import
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

///this function crops and compress the profile picture [File]
Future<File> cropImage(File imageFile) async {
  print("cropping image"); //todo: remove debug print
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = new Random().nextInt(10000);
  int proPicDimension = 200; //here is defined the size width of the profile pictures

  Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());
  image = _imageSquarer(image);
  image = Im.copyResize(image, proPicDimension);
  print("image cropped");
  imageFile = new File('$path/img_$rand.jpg')
    ..writeAsBytesSync(Im.encodeJpg(image, quality: 75));
  return imageFile;
}

Im.Image _imageSquarer(Im.Image image){
  if(image.width > image.height){
    int newWidth = image.height;
    image = Im.copyCrop(image,
        ((image.width/2).round() - (newWidth/2).round()),
        0,
        newWidth,
        newWidth);
  }else{
    int newHeight = image.width;
    image = Im.copyCrop(image,
        0,
        ((image.width/2).round() - (newHeight/2).round()),
        newHeight,
        newHeight);
  }
  return image;
}

///this function compress the image picture [File]
Future<File> compressImage(File imageFile) async {
  print("compressing image"); //todo: remove debug print
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = new Random().nextInt(10000);

  Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());

  int widthFinal = 0;
  //algorithm to decide the image width
  if (image.height > image.width) {
    widthFinal = 1080;
    if (image.width > 1080) {
      image = Im.copyResize(image, widthFinal);
    }
  } else {
    widthFinal = ((image.width * 1080) / image.height).round();
    if (image.height > 1080) {
      image = Im.copyResize(image, widthFinal);
    }
  }
  print("image compressed");//todo: remove debug print
  imageFile = new File('$path/img_$rand.jpg')
    ..writeAsBytesSync(Im.encodeJpg(image, quality: 50));
  return imageFile;
}
