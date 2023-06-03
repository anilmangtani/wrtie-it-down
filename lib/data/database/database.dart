
import 'package:hive_flutter/adapters.dart';

class ToDoListDatabase{
  List ToDoListContent = [];
  final _mybox = Hive.box('mybox');

  void createInitialData(){
    ToDoListContent = [
      ["Select the box then swipe left", false],
    ];
  }

  void loadData(){
    ToDoListContent = _mybox.get('TODOLIST');
  }

  void updateData(){
    _mybox.put("TODOLIST", ToDoListContent);
  }
}