import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/utils/constants/string_const.dart';

class NotesDatabase {
  Box<NotesModel> notesBox = Hive.box<NotesModel>(notesBoxName);

  Future<void> addNotes({
    required String? id,
    required String? noteTitle,
    required String? noteDescription,
    required String? dateTime,
  }) async {
    await notesBox.put(
      id,
      NotesModel(
        id: id ?? '',
        noteTitle: noteTitle ?? '',
        noteDescription: noteDescription ?? '',
        dateTime: dateTime ?? '',
      ),
    );
  }

  NotesModel? readSpecificNote({
    required String? id,
  }) {
    log(notesBox.getAt(int.parse(id ?? '')).toString(),
        name: 'Get Data of $id');
    return notesBox.getAt(int.parse(id ?? ''));
  }

  List readAllNotes() {
    log(notesBox.values.toList().toString(), name: 'Get All Hive Box Data');
    return notesBox.values.toList();
  }

  Future<void> deleteSpecificNote({
    String? id,
  }) async {
    await notesBox.delete(id);
  }
}
