import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/categoryModel.dart';
import '../models/photosModel.dart';

class ApiOperation {
  static List<PhotosModel> trendingWallpaper = [];
  static List<PhotosModel> searchWallpaperList = [];
  static List<CategoryModel> cateogryModelList = [];
  static Future<List<PhotosModel>> getTradingWallpaper() async {
    // await http.get("Zk72nuaRVhKSDaWeri66FRDaUFlBaWxiYChtR0fNZF40A5DoEul1NZeq")
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/curated?per_page=80",
        ),
        headers: {
          "Authorization":
              "Zk72nuaRVhKSDaWeri66FRDaUFlBaWxiYChtR0fNZF40A5DoEul1NZeq"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        Map<String, dynamic> src = element['src'];
        trendingWallpaper.add(PhotosModel.fromAPI2APP(element));
      });
    });
    return trendingWallpaper;
  }

  static Future<List<PhotosModel>> searchWallpaper(String query) async {
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        ),
        headers: {
          "Authorization":
              "Zk72nuaRVhKSDaWeri66FRDaUFlBaWxiYChtR0fNZF40A5DoEul1NZeq"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpaperList.clear();
      photos.forEach((element) {
        searchWallpaperList.add(PhotosModel.fromAPI2APP(element));
      });
    });
    return searchWallpaperList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "God",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
          (await searchWallpaper(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgsrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgsrc, catName: catName));
    });

    return cateogryModelList;
  }
}
