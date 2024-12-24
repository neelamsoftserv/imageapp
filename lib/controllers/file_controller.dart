import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:image_picker/image_picker.dart';


class FileController extends GetxController {

  File ?   imageFile ;
  String ? path ;


  Future<String?>pickImageFun(ImageSource source) async {

    ImagePicker imagePicker = ImagePicker();


    await imagePicker.pickImage(source: source).then((value) async {

      if(value!=null){
        imageFile = File(value.path);
        path = imageFile?.path.split('/').last;
        print("path  ${imageFile?.path}");

      final originalExtension =   path?.split(".").last;
      if(originalExtension == "jpeg" || originalExtension == "png"){
        final bytes = await imageFile!.readAsBytes();
        return base64Encode(bytes);
      }
      else{
        convertHeiC(imageFile?.path??"");
      }
    }
    }
    );
  }

  Future<void> convertHeiC(String path) async {
    String jpegPath = path.replaceAll('.heic', 'jpeg');
    String? jpegPathNew =  await  HeifConverter.convert(path,format: 'jpeg',output: jpegPath);
    print("jpeg path  ${path}");
  }
}