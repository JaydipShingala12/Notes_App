import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String noteTitle;

  @HiveField(2)
  final String noteDescription;

  @HiveField(3)
  final String dateTime;

  NotesModel({
    required this.id,
    required this.noteTitle,
    required this.noteDescription,
    required this.dateTime,
  });
}
