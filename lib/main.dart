import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditaion/Screens/Settings.dart';
import 'Screens/Home.dart';

void main() => runApp(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/settings', page: () => Settings()),
      ],
      debugShowCheckedModeBanner: false,
    ));
