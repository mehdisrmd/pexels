// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import 'package:unsplash/controllers/wallpaper_Provider.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key}) : super(key: key);
  

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    final data = Get.arguments;

    return Scaffold(
      body: Stack(children: [
        Hero(
            tag: data,
            child: SizedBox(
              height: he,
              width: wi,
              child: Image.network(
                data,
                fit: BoxFit.cover,
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder(
                    future: loading
                        ? Get.find<WallpaperProvider>()
                            .saveGallery(data)
                        : null,
                    builder: (ctx, snopshot) {
                      if (snopshot.connectionState == ConnectionState.done) {
                        return elevateButton(context, ' Saved', false, data);
                      } else if (snopshot.connectionState ==
                          ConnectionState.none) {
                        return elevateButton(
                            context, 'Save to Gallery', false, data);
                      } else if (snopshot.connectionState ==
                          ConnectionState.waiting) {
                        return elevateButton(context, 'Saving..', false, data);
                      } else if (snopshot.hasError) {
                        return elevateButton(
                            context, 'Save to Gallery', true, data);
                      }
                      return const SizedBox();
                    }),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF05a081))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF060607)),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  ElevatedButton elevateButton(
      BuildContext context, String text, bool temp, String data) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF05a081))),
        onPressed: () async {
          await GallerySaver.saveImage(data, albumName: 'Pexels');
          setState(() {
            loading = true;
          });
         Get.snackbar('error', 'failed!!');
          
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ));
  }
}
