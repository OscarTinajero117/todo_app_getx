import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  ///Initialize the services
  Future<StorageService> init() async {
    _box = GetStorage();

    ///init the box of Storage
    await _box.writeIfNull(taskKey, []);
    return this;
  }

  ///Read box function
  T read<T>(String key) => _box.read(key);

  ///Write in box function
  void write(String key, dynamic value) async => await _box.write(key, value);
}
