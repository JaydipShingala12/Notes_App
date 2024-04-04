import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/utils/constants/string_const.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>(notesBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0).clamp(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.2,
            ),
          ),
          child: child ??
              Container(
                color: Colors.amber,
              ),
        );
      },
      home: const HomePage(),
    );
  }
}
