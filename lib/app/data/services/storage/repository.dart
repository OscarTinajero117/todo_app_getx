import '../../models/task.dart';
import '../../providers/task/provider.dart';

class TaskRepository {
  ///Instance of TaskProvider
  final TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  ///Read all Tasks
  List<Task> readTasks() => taskProvider.readTask();

  ///Write the Tasks
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
