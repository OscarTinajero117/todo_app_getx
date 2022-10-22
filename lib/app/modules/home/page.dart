import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/values/colors.dart';
import '../../data/models/task.dart';
import 'controller.dart';
import '../../core/utils/extensions.dart';
import 'widgets/add_card.dart';
import 'widgets/add_dialog.dart';
import 'widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My List',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map((element) => LongPressDraggable(
                            data: element,
                            onDragStarted: () => controller.deleting = true,
                            onDraggableCanceled: (velocity, offset) =>
                                controller.deleting = false,
                            onDragEnd: (details) => controller.deleting = false,
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: element),
                            ),
                            child: TaskCard(task: element),
                          ))
                      .toList(),
                  AddCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (context, candidateData, rejectedData) {
          return Obx(() => FloatingActionButton(
                backgroundColor: controller.deleting ? Colors.red : blue,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showInfo('Please create your task type');
                  }
                },
                child: Icon(
                  controller.deleting ? Icons.delete : Icons.add,
                ),
              ));
        },
        onAccept: (data) {
          controller.deleteTask(data);
          EasyLoading.showSuccess('Delete Sucess');
        },
      ),
    );
  }
}
