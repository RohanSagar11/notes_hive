import 'package:hive/hive.dart';
import 'package:notes_hive/model/note_model.dart';

class Boxes{
 static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}