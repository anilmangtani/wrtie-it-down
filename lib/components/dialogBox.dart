import 'package:flutter/material.dart';

import 'Button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onsave;
  VoidCallback onCancel;

  DialogBox({super.key, 
  required this.controller,
  required this.onCancel,
  required this.onsave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border:UnderlineInputBorder(),
              hintText: "Add a new To Do",
            ),
          ),
          Row(
            children: [
              MyButton(text:"Save", onPressed: onsave),
              const SizedBox(width: 4,),
              MyButton(text:"Cancel", onPressed: onCancel),
            ],
          ),
        ],),
      ),
    );
  }
}