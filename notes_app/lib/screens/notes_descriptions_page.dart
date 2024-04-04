import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/notes_descriptions_page_controller.dart';
import 'package:notes_app/utils/text.dart';

class NotesDescription extends GetView<NotesDescriptionController> {
  const NotesDescription({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotesDescriptionController());
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () => controller.isNoted.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await controller.saveNoteToStorage();
                      },
                      icon: const Icon(
                        Icons.task_alt,
                        semanticLabel: 'Save',
                        applyTextScaling: true,
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: NotesDescriptionController(),
          builder: (controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.notesTitleController.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) => controller.saveNotesIconUpdate(),
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: text(
                    controller.dateTime,
                  ),
                ),
                const Divider(
                  color: Colors.black12,
                  height: 10,
                  thickness: 1,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height * 0.8),
                  child: TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: controller.notesDetailsController.value,
                    onChanged: (value) => controller.saveNotesIconUpdate(),
                    decoration: const InputDecoration(
                      hintText: 'Start Typing',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
