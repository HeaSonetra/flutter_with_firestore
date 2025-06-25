import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_note/model/note_model.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var namecontroller=TextEditingController();

  var desccontroller=TextEditingController();

  List<Note>  note=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.amber,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, 
          builder: (context)=>AlertDialog(
             title: Text("Add item"),
             content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter name"
                  ),
                ),
                SizedBox(height: 40,),
                 TextField(
                  controller: desccontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter description"
                  ),
                ),
              ],
             ),
             actions: [
                OutlinedButton(onPressed: (){
                    Navigator.pop(context);
                }, child: Text("Cancel")),
                TextButton(
                onPressed: (){
                     String name=namecontroller.text.trim();
                     String desc=desccontroller.text.trim();
                     addNote(Note(name: name, desc: desc), context);
                     setState(() {
                       
                     });
                     Navigator.pop(context);
                },
                child: Text("Add"))
             ],

          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  addNote(Note note,BuildContext context){
        FirebaseFirestore db=FirebaseFirestore.instance;

        db.collection("Notes").doc(DateTime.now().toString()).set(
          Note.toMap(note)
        ).then((value){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add successfuly")));
        });
  }
}