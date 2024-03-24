import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_hive/frontend/home_notes.dart';
import 'package:notes_hive/model/note_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomeNotes()
    );
  }
}


