import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/screens/notes_descriptions_page.dart';
import 'package:notes_app/utils/constants/string_const.dart';
import 'package:notes_app/utils/text.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        title: text(
          'Notes',
          fontSize: 20,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const NotesDescription(), arguments: {
            'update': false,
          });
        },
        elevation: 10,
        child: const Icon(Icons.add),
      ),
      body: GetBuilder(
        init: HomePageController(),
        builder: (controller) => controller.isNotesEmpty.value
            ? Center(
                child: text(
                  'Add Your Notes...',
                  fontSize: 20,
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: controller.notesList.length,
                itemBuilder: (context, index) {
                  NotesModel notesModel = controller.notesList[index];
                  log(notesModel.dateTime.toString(), name: 'Notes Model');
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const NotesDescription(), arguments: {
                        singleNoteKey: notesModel,
                        'update': true,
                      });
                    },
                    onLongPress: () {
                      Get.defaultDialog(
                        barrierDismissible: false,
                        title: 'Delete Note',
                        titleStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        titlePadding: const EdgeInsets.only(top: 20),
                        contentPadding: const EdgeInsets.all(20),
                        middleText: 'Are you sure?',
                        middleTextStyle: const TextStyle(
                          fontSize: 20,
                        ),
                        textConfirm: 'Yes',
                        onConfirm: () async {
                          await controller.notesDatabase.deleteSpecificNote(
                            id: notesModel.id,
                          );
                          await controller.onInit();
                          Get.back();
                          Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_SHORT,
                            msg: '${notesModel.noteTitle} Deleted',
                            backgroundColor: Colors.red,
                          );
                        },
                        textCancel: 'No',
                        onCancel: () => Get.back(),
                      );
                    },
                    child: Card(
                      borderOnForeground: true,
                      color: Colors.green,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(
                              notesModel.noteTitle,
                              fontSize: 25,
                            ),
                            Expanded(
                              child: text(
                                notesModel.noteDescription,
                                fontSize: 20,
                                clr: Colors.black54,
                              ),
                            ),
                            text(
                              notesModel.dateTime,
                              fontSize: 12,
                              clr: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
