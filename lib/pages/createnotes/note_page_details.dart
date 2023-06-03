import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/db/notes_database.dart';
import 'package:notes/model/notes.dart';
import 'edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
    const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshNotes();
  }


  Future refreshNotes() async{
    setState(()=>isloading = true);
    this.note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(()=>isloading = false);
  }

  @override
  Widget build(BuildContext context) {

  Widget editButton() => IconButton(
  icon: Icon(Icons.edit), 
  onPressed:() async{
    if(isloading) return;
     await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));
        refreshNotes();
    }
  );

  
  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      await NotesDatabase.instance.delete(widget.noteId);
      Navigator.of(context).pop();
    }, 
    );

    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()]
        ,
      ),
      body: isloading
      ? Center(child: CircularProgressIndicator())
      :Padding(padding: EdgeInsets.all(12),
        child: ListView(padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            note.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            note.description,
            style: TextStyle(color:Colors.black54, fontSize: 18),
          )
        ],
        ),
      )
    );  



  }
}


















