import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/components/dialogBox.dart';

import '../components/todotile.dart';
import '../data/database/database.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final _mybox = Hive.box('mybox');
  ToDoListDatabase db = ToDoListDatabase();
  
  @override
  void initState() {
    // TODO: implement initState
    if(_mybox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }
  


  final _controller = TextEditingController();
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.ToDoListContent[index][1] = !db.ToDoListContent[index][1];
    });
    db.updateData();
  }

  void saveNewTask(){
    setState(() {
      db.ToDoListContent.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask(){
    showDialog(context: context, 
    builder: (context){
      return DialogBox(controller: _controller, onCancel: ()=> Navigator.of(context).pop() , onsave: saveNewTask,);
    });
  }

  void deleteTask(int index){
    setState(() {
      db.ToDoListContent.removeAt(index);
    });
    db.updateData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    body: ListView.builder(
      itemCount: db.ToDoListContent.length,
      itemBuilder: (context, index){
        return ToDoListTile(
          taskName: db.ToDoListContent[index][0],
          taskCompleted: db.ToDoListContent[index][1],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
        );
      },
    ),
    );

  }
}




