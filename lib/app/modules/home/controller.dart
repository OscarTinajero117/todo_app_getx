import 'package:flutter/foundation.dart';
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

  final chipIndex = 0.obs;

  final tabIndex = 0.obs;

  final deleting = false.obs;

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

  bool addTodo(String title) {
    final todo = {'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    final doneTodo = {'title': title, 'done': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    final newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);

    final newTask = task.value!.copyWith(todos: newTodos);
    final oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    final doingTodo = {'title': title, 'done': false};
    final index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    final doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    final index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));

    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodoEmpty(Task task) => task.todos == null || task.todos!.isEmpty;

  int getDoneTodo(Task task) {
    int result = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      if (task.todos![i]['done'] == true) {
        result += 1;
      }
    }
    return result;
  }

  int getTotalTask() {
    int result = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        result += tasks[i].todos!.length;
      }
    }
    return result;
  }

  int getTotalDoneTask() {
    int result = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (var j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            result += 1;
          }
        }
        // result += tasks[i].todos!.length;
      }
    }
    return result;
  }
}
