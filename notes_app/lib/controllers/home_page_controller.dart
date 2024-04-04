import 'package:get/get.dart';
import 'package:notes_app/models/notes_database.dart';
import 'package:notes_app/models/notes_model.dart';

class HomePageController extends GetxController {
  RxBool isNotesEmpty = true.obs;
  RxList<NotesModel> notesList = <NotesModel>[].obs;
  NotesDatabase notesDatabase = NotesDatabase();

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkNotesDatabase();
  }

  Future<void> checkNotesDatabase() async {
    List<NotesModel> notes = notesDatabase.readAllNotes() as List<NotesModel>;
    if (notes.isEmpty) {
      isNotesEmpty.value = true;
    } else {
      notesList.clear();
      notesList.addAll(notes);
      isNotesEmpty.value = false;
    }
    update();
  }
}
