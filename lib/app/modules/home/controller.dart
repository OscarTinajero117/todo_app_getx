import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/task.dart';
// import '../../data/models/todo.dart';
import '../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();

  final editController = TextEditingController();

  final _chipIndex = 0.obs;
  int get chipIndex => _chipIndex.value;
  set chipIndex(int value) => _chipIndex.value = value;

  final _deleting = false.obs;
  bool get deleting => _deleting.value;
  set deleting(bool value) => _deleting.value = value;

  final tasks = <Task>[].obs;

  final task = Rx<Task?>(null);

  final doingTodos = [].obs;

  final doneTodos = [].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  bool updateTask(Task task, String title) {
    final todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    final todo = {'title': title, 'done': false};
    // final todo = ToDo(title: title, done: false);
    todos.add(todo);
    final newTask = task.copyWith(todos: todos);
    final oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, String title) =>
      todos.any((element) => element['title'] == title);

  void changeTodos(List select) {
    doingTodos.clear();
    doneTodos.clear();
    for (var element in select) {
      final bool status = element['done'];
      if (status) {
        doneTodos.add(element);
      } else {
        doingTodos.add(element);
      }
    }
  }
}
