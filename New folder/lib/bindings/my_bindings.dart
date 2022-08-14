import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:unsplash/controllers/wallpaper_Provider.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WallpaperProvider>(() => WallpaperProvider());

  }
}
