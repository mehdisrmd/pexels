// ignore_for_file: file_names

import 'dart:convert';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:unsplash/models/wallpaper.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class WallpaperProvider extends GetxController {
  @override
  void onReady() {

     randomPhoto();
    super.onReady();
  }

 

  RxBool loading = false.obs;
  RxBool error = false.obs;
  String item = 'curated';
  final String _apiKey =
      '563492ad6f917000010000011c649aa03fc3487bbe60c4d64707811f';

  WallpaperModel? wallpaperModel;

  Future<void> randomPhoto() async {
    try {
      loading.value = true;
      var url = Uri.parse('https://api.pexels.com/v1/curated');
      var response = await http
          .get(url, headers: {'Authorization': _apiKey})
          .timeout(const Duration(seconds: 10))
          .onError((error, stackTrace) {
            Get.showSnackbar(const GetSnackBar(
              title: "error",
              message: "no intenrent connection",
              duration: Duration(seconds: 2),
            ));
            throw Exception("error");
          });
      if (response.statusCode == 200) {
        wallpaperModel = WallpaperModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("error");
      }
    } catch (e) {
      error.value = true;
    } finally {
      loading.value = false;
    }
  }

  Future<void> saveGallery(String data) async {
    await GallerySaver.saveImage(data);
  }

  Future<void> searchWallpaper(String item) async {
    this.item = item;
    if (item == 'curated') error.value = false;
    try {
      loading.value = true;
      Uri url;
      if (item == 'curated') {
        url = Uri.parse('https://api.pexels.com/v1/curated');
      } else {
        url = Uri.parse('https://api.pexels.com/v1/search?query=$item');
      }
      var response = await http
          .get(url, headers: {'Authorization': _apiKey})
          .timeout(const Duration(seconds: 10))
          .onError((error, stackTrace) {
            Get.showSnackbar(const GetSnackBar(
              title: "error",
              message: "no intenrent connection",
              duration: Duration(seconds: 2),
            ));
            throw Exception("error");
          });

      if (response.statusCode == 200) {
        wallpaperModel = WallpaperModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("error");
      }
    } catch (e) {
      error.value = true;
    } finally {
      loading.value = false;
    }
  }
}
