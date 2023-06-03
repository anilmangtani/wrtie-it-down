import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangeImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangedDescription;


  const NoteFormWidget({
  Key? key, 
  this.isImportant = false, 
  this.number = 0, 
  this.title = '', 
  this.description= '', 
  required this.onChangeImportant, 
  required this.onChangeNumber, 
  required this.onChangeTitle, 
  required this.onChangedDescription}): super(key: key);

  Widget buildTitle()=> TextFormField(
    maxLines: 1,
    initialValue: title,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title)=> title != null && title.isEmpty ? 'The title cannot be empty': null,
    onChanged: onChangeTitle,
  );

  Widget buildDescription()=> TextFormField(
    maxLines: 5,
    initialValue: description,
    style: TextStyle(color: Colors.black87, fontSize: 18),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.black87),
    ),
    validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Switch(value: isImportant?? false, onChanged: onChangeImportant,),
                Expanded(child: Slider(value: (number??0).toDouble(),
                min: 0, max: 5, divisions: 5, 
                onChanged: (number)=>onChangeNumber(number.toInt())))
              ],
            ),
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}