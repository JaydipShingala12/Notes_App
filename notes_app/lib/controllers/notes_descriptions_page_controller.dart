import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/models/notes_database.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/utils/constants/string_const.dart';

class NotesDescriptionController extends GetxController {
  Rx<TextEditingController> notesTitleController = TextEditingController().obs;
  Rx<TextEditingController> notesDetailsController =
      TextEditingController().obs;
  RxBool isNoted = false.obs;
  String? noteId;
  String dateTime = DateFormat('d MMMM hh:mm a').format(DateTime.now());
  NotesDatabase notesDatabase = NotesDatabase();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments['update'] == true) {
      NotesModel singleNote = Get.arguments[singleNoteKey];
      notesTitleController.value.text = singleNote.noteTitle;
      notesDetailsController.value.text = singleNote.noteDescription;
      dateTime = singleNote.dateTime;
      noteId = singleNote.noteTitle;
      saveNotesIconUpdate();
    } else if (arguments['update'] == false) {
      noteId = '';
      notesTitleController.value.text = '';
      notesDetailsController.value.text = '';
    }
  }

  void saveNotesIconUpdate() {
    if (notesDetailsController.value.text.isEmpty &&
        notesTitleController.value.text.isEmpty) {
      isNoted.value = false;
    } else {
      isNoted.value = true;
    }
    update();
  }

  Future<void> saveNoteToStorage() async {
    await notesDatabase.addNotes(
      id: (noteId?.isEmpty ?? true) ? notesTitleController.value.text : noteId,
      noteTitle: notesTitleController.value.text,
      noteDescription: notesDetailsController.value.text,
      dateTime: dateTime,
    );
    Get.delete<HomePageController>();
    Get.offAll(() => const HomePage());
    update();
  }
}
