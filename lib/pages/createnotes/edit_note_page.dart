import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/db/notes_database.dart';
import 'package:notes/widget/note_card_widget.dart';

import '../../widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note
  }): super(key: key);

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? "";
    description = widget.note?.description ?? "";
  }


  @override
  Widget build(BuildContext context) {

    Future updateNote() async{
      final note = widget.note!.copy(
        isImportant: isImportant,
        number: number,
        title: title,
        description: description
      );
      await NotesDatabase.instance.update(note);
    }

    Future addNote() async{
      final note = Note(
        title: title,
        isImportant: isImportant,
        number: number,
        description: description,
        createdTime: DateTime.now(),
      );
    await NotesDatabase.instance.create(note);
    }

    void addOrUpdate() async{
      final isValid = _formKey.currentState!.validate();
      if(isValid){
        final isUpdating = widget.note != null;
        if(isUpdating){
            await updateNote();
        }else{
            await addNote();
        }
        Navigator.of(context).pop();
      }
    }
    Widget buildButton() {
      final isFormValid = title.isNotEmpty && description.isNotEmpty;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: isFormValid ? null : Colors.grey.shade700,
          ),
          onPressed: addOrUpdate,
          child: Text('Save'),
        ),);
        
      
    }

    return Scaffold(
      appBar: AppBar(actions: [buildButton()]),
      body: Form(
        key: _formKey,
        child: NoteFormWidget(
          isImportant: isImportant,
          number: number,
          title: title,
          description: description,
          onChangeImportant: (isImportant)=>
            setState(()=> this.isImportant = isImportant),
            onChangeNumber: (number)=> setState(()=> this.number = number),
            onChangeTitle: (title)=>setState(()=>this.title = title),
              onChangedDescription: (description) =>
                setState(() => this.description = description),
        ),
        ),
    );
  }
}