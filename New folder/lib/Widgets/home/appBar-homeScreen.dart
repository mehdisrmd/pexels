 // ignore_for_file: file_names
  import 'package:flutter/material.dart';

appBarHomeScreen() {
    return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Pexels',
          style: TextStyle(color: Color(0xFF060607), fontSize: 33),
        ),
        const SizedBox(
          width: 3,
        ),
        Image.asset('assets/images/logo-pexcel.png'),
      ],
    ),
    elevation: 0,
  );
  }