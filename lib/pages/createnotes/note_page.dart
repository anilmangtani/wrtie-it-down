import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/db/notes_database.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/pages/createnotes/edit_note_page.dart';

import '../../widget/note_card_widget.dart';
import 'note_page_details.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> notes;
  bool isloading = false;

  @override
  void initState() {
    refreshNotes();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isloading = true);
    this.notes = await NotesDatabase.instance.readAll();
    setState(() => isloading = false);
  }

  @override
  Widget build(BuildContext context) {

     Widget buildNotes()=>StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: notes.length,
    staggeredTileBuilder: (index)=>StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index){
      final note = notes[index];

      return GestureDetector(
        onTap: () async{
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=> NoteDetailPage(noteId: note.id!),));
            refreshNotes();
        },
        child: NoteCardWidget(note: note, index:index),
      );
    },
  );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 24),
        ),
        actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
          child: isloading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'No Notes',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : buildNotes(), 
                  ),

                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () async{
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>AddEditNotePage()),
                      );
                      refreshNotes();
                    },
                  ),
    );

  }
}
