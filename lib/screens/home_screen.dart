import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:unsplash/controllers/wallpaper_Provider.dart';
import 'package:unsplash/Widgets/home/appBar-homeScreen.dart';
import 'package:unsplash/Widgets/home/gridView-homeScreen.dart';
import 'package:unsplash/Widgets/home/search_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Get.put<WallpaperProvider>(WallpaperProvider());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarHomeScreen(),
        body: Column(
          children: [
              SearchBox(),
            GetX<WallpaperProvider>(builder: (controller) {
              return controller.loading.value
                  ?const Center(
                    child:  Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child:
                                CircularProgressIndicator(color: Colors.green)),
                      ),
                  )
                  :  GridViewBuilderWidget();
            })
          ],
        ));
  }
}







  // FutureBuilder(
            //     future: apiData.randomPhoto(),
            //     builder: (context, AsyncSnapshot<dynamic> snopshot) {
            //       if (snopshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (snopshot.connectionState == ConnectionState.done) {
            //         if (apiData.error.value) {
            //           return Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: CustomErrorWidget(
            //                 wi: wi, he: he, wallpaperData: apiData),
            //           );
            //         } else if (snopshot.hasData) {
            //           return Expanded(
            //             child: Container(
            //                 margin: const EdgeInsets.only(top: 10, bottom: 10),
            //                 padding: const EdgeInsets.symmetric(horizontal: 16),
            //                 child: GridView.builder(
            //                     shrinkWrap: true,
            //                     gridDelegate:
            //                         SliverGridDelegateWithFixedCrossAxisCount(
            //                       crossAxisCount: Platform.isWindows ? 3 : 2,
            //                       childAspectRatio: .6,
            //                       mainAxisSpacing: 10,
            //                       crossAxisSpacing: 10,
            //                     ),
            //                     itemCount: snopshot.data?.totalResults - 1 ?? 0,
            //                     itemBuilder: (context, index) {
            //                       return Hero(
            //                         tag: snopshot
            //                             .data!.photos![index].src!.portrait
            //                             .toString(),
            //                         child: ClipRRect(
            //                             borderRadius: BorderRadius.circular(10),
            //                             child: Image.network(
            //                               snopshot.data!.photos![index].src!
            //                                   .portrait!,
            //                               fit: BoxFit.cover,
            //                               filterQuality: FilterQuality.high,
            //                             )),
            //                       );
            //                     })),
            //           );
            //         }
            //       }
            //       return const Text("hi");
            //     }),