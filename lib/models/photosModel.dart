import 'package:flutter/services.dart';

class PhotosModel {
  String imgsrc;
  String phtotoGrapherName;

  PhotosModel({
    required this.imgsrc,
    required this.phtotoGrapherName,
  });

  // APi-JOSN
  // App - Map
  static PhotosModel fromAPI2APP(Map<String, dynamic> photoMap) {
    return PhotosModel(
        imgsrc: (photoMap['src'])["portrait"],
        phtotoGrapherName: photoMap["photographer"]);
  }
}
