// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:unsplash/controllers/wallpaper_Provider.dart';

class SearchBox extends StatelessWidget {
  var item = TextEditingController();
  Timer? searchOnStoppedTyping;
  void onChangeHandler(value) {
    const duration = Duration(milliseconds: 1500);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = Timer(
      duration,
      () {
        if (item.text != '') {
          Get.find<WallpaperProvider>().page = 1;
          Get.find<WallpaperProvider>().searchWallpaper(item.text);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        maxLength: 25,
        controller: item,
        onChanged: (_) {
          onChangeHandler(item.text);
        },
        onSubmitted: (_) {
          Get.find<WallpaperProvider>().searchWallpaper(item.text);
        },
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        showCursor: true,
        cursorColor: const Color(0xFF05a081),
        decoration: InputDecoration(
            counter: const SizedBox(),
            prefixIcon: IconButton(
                onPressed: () async {
                  await Get.find<WallpaperProvider>()
                      .searchWallpaper(Get.find<WallpaperProvider>().item);
                },
                icon: const Icon(
                  Icons.search_sharp,
                  color: Color(0xFF060607),
                )),
            hintText: 'Search',
            border: InputBorder.none),
      ),
    );
  }
}
