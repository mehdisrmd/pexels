// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:unsplash/controllers/wallpaper_Provider.dart';

class GridViewBuilderWidget extends StatelessWidget {
  final cont = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<WallpaperProvider>(initState: (state) {
          cont.addListener(() {
            print('first');
            if (cont.position.maxScrollExtent == cont.offset) {
              print('lageter');
              Get.find<WallpaperProvider>().page++;
              Get.find<WallpaperProvider>()
                  .searchWallpaper(
                    Get.find<WallpaperProvider>().item,
                  )
                  .then((value) =>
                      Get.find<WallpaperProvider>().loading.value = false);
            }
          });
        }, builder: ((controller) {
          return GridView.builder(
            controller: cont,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Platform.isWindows ? 3 : 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: controller.wallpaperModel?.photos?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed('/image_view_screen',
                    arguments: controller
                        .wallpaperModel?.photos![index].src?.portrait),
                child: Hero(
                  tag: controller.wallpaperModel!.photos![index].src!.portrait
                      .toString(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        controller
                            .wallpaperModel!.photos![index].src!.portrait!,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      )),
                ),
              );
            },
          );
        })),
      ),
    );
  }
}
