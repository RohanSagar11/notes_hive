import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_hive/boxes/boxes.dart';
import 'package:notes_hive/model/note_model.dart';

class NotesList extends StatefulWidget {
   NotesList({super.key,});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  void delete(NotesModel notesModel)async{
      await notesModel.delete();
    }

  Future<void> _editDialog(NotesModel notesModel, String title, String description)async{
      final titleController = TextEditingController();
      final descController = TextEditingController();
      titleController.text = title;
      descController.text= description;
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Add Notes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Enter Title",
                ),
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                  hintText: "Enter Description",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            notesModel.title = titleController.text.toString();
            notesModel.description = descController.text.toString();
            notesModel.save();
            titleController.clear();
            descController.clear();
            Navigator.pop(context);
          }, child: Text('Save')),


        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(valueListenable: Boxes.getData().listenable(), builder: (context, box, _){
      var data = box.values.toList()..cast<NotesModel>();
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            return Card(
            elevation: 5,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                  Container(
                    width: 200,
                    child: Padding(
                      
                      padding: EdgeInsets.all(5.0),
                      child: Text(data[index].title.toString(), overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(data[index].description.toString(), overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(DateTime.now().toString()),
                  )
                            ],
                          ),
                ),
                Column(
                  children: [
                    IconButton(onPressed: (){
                      delete(data[index]);
                    }, icon: const Icon(Icons.delete_forever, color: Colors.red,)),
                    IconButton(onPressed: (){
                      _editDialog(data[index], data[index].title, data[index].description);
                    }, icon: const Icon(Icons.edit), color: Colors.yellow,)
                  ],
                )
                
              ],
            )
          );
          },
          
        ),
      );
  });}
}
