import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const gradient = LinearGradient(
    colors: [
      Color(0xff9746ff),
      Color.fromARGB(255, 128, 39, 176),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.5, 1.0],
  );

  static const primaryColor = Color(0xff9746ff);
  static const primaryLightColor = Color(0xffe1d4ff);
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color(0xff9746ff);
  static const unselectedNavBarColor = Colors.black87;
  static const blackColor = Colors.black87;

  static const List<Map<String, String>> productCategory = [
    {
      'title': 'SmartPhone',
      'image': 'assets/category/smartphone.png',
    },
    {
      'title': 'Laptop',
      'image': 'assets/category/laptop.png',
    },
    {
      'title': 'Tablet',
      'image': 'assets/category/tablet.png',
    },
    {
      'title': 'Speakers',
      'image': 'assets/category/speaker.png',
    },
    {
      'title': 'SmartWatch',
      'image': 'assets/category/smartwatch.png',
    },
    {
      'title': 'HeadPhones',
      'image': 'assets/category/headphone.png',
    },
  ];
}
