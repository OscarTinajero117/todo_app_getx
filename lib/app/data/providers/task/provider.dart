import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  ///Use storage Services
  final _storage = Get.find<StorageService>();

  ///Read the Task in the Storage
  List<Task> readTask() {
    final tasks = <Task>[];

    ///Get all Tasks and put in List
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));

    ///return the list of Tasks
    return tasks;
  }

  ///Write the Tasks
  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
