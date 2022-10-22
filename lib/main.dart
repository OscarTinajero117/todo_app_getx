import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/services/storage/services.dart';
import 'app/modules/home/binding.dart';
import 'app/modules/home/page.dart';
import 'app/routers/pages.dart';
import 'app/routers/routes.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(GetMaterialApp(
    title: 'To Do App',
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: ThemeData.light(),
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
    home: const HomePage(),
    builder: EasyLoading.init(),
  ));
}
