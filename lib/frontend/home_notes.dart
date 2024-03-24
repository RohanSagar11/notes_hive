import 'package:flutter/material.dart';
import 'package:notes_hive/boxes/boxes.dart';
import 'package:notes_hive/frontend/notes_list.dart';
import 'package:notes_hive/model/note_model.dart';

class HomeNotes extends StatefulWidget {
  const HomeNotes({Key? key});

  @override
  State<HomeNotes> createState() => _HomeNotesState();
}

class _HomeNotesState extends State<HomeNotes> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    Future<void> _showMyDialog() async{
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
            final data = NotesModel(title: titleController.text, description: descController.text);
            Navigator.pop(context);
            final box = Boxes.getData();
            box.add(data);
            titleController.clear();
            descController.clear();
          }, child: Text('Add')),


        ],
      );
    });
  }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 50),
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        onPressed: () {
          _showMyDialog();
          // var box = await Hive.openBox("rohan");
          // box.put("firstname", "Rohan");
          // box.put("second", "Sagar");
          // print(box.get("firstname"));
          // print(box.get("second"));
        },
        child: const Icon(Icons.add, size: 30,),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
            
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: null, icon: Icon(Icons.check_box_outline_blank, color: Colors.white,),),
                IconButton(onPressed: null, icon: Icon(Icons.search, color: Colors.white,),),
                IconButton(onPressed: null, icon: Icon(Icons.menu_sharp, color: Colors.white,),)
              ],
            ),
          ),
          Expanded(
            child: NotesList()
          ),
        ],
      ),
    );
    

  }

  
}
