import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:unsplash/bindings/my_bindings.dart';

import 'package:unsplash/screens/home_screen.dart';
import 'package:unsplash/screens/imageView_screen.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      initialRoute: '/home_screen',
      getPages: [
        GetPage(
          name: '/home_screen',
          page: (() => const HomeScreen()),
        ),
        GetPage(name: '/image_view_screen', page: (() => const ImageView())),
      ],
      theme: ThemeData(
        textTheme:
            const TextTheme(headline6: TextStyle(color: Color(0xFF060607))),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
