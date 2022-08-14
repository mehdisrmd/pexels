import 'package:flutter/material.dart';
import 'package:unsplash/controllers/wallpaper_Provider.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    required this.wi,
    required this.he,
    required this.wallpaperData,
  }) : super(key: key);

  final double wi;
  final double he;
  final WallpaperProvider wallpaperData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const FittedBox(
              child: Text('Somthing going wrong..!',
                  style: TextStyle(
                      color: Color(0xFF060607),
                      fontSize: 33,
                      fontWeight: FontWeight.w500))),
          SizedBox(
            width: wi * .8,
            height: he * .6,
            child: ClipRRect(
                child:
                    Image.asset('assets/images/erorr.jpg')),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF05a081))),
              onPressed: () async {
                await wallpaperData
                    .searchWallpaper(wallpaperData.item);
              },
              child: const Text(
                'Try Again',
                style: TextStyle(color: Color(0xFF060607)),
              ))
        ],
      ),
    );
  }
}