import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/values/colors.dart';
import '../../../data/models/task.dart';
import '../../../widgets/icons.dart';
import '../controller.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    final squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.dialog(
            AlertDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              title: Text(
                'Task Type',
                style: TextStyle(
                  fontSize: 14.0.sp,
                ),
              ),
              scrollable: true,
              content: Form(
                key: homeController.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: homeController.editController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey.shade200,
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeController.chipIndex == index,
                                      onSelected: (value) {
                                        homeController.chipIndex =
                                            value ? index : 0;
                                      },
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            int icon =
                                icons[homeController.chipIndex].icon!.codePoint;
                            String color =
                                icons[homeController.chipIndex].color!.toHex();

                            final task = Task(
                              color: color,
                              icon: icon,
                              title: homeController.editController.text,
                            );
                            Get.back();
                            homeController.addTask(task)
                                ? EasyLoading.showSuccess('Create Sucess')
                                : EasyLoading.showError('Duplicate Task');
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          homeController.editController.clear();
          homeController.chipIndex = 0;
        },
        child: DottedBorder(
          color: Colors.grey.shade400,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
