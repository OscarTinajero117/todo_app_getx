// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../modules/home/binding.dart';
import '../modules/home/page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
