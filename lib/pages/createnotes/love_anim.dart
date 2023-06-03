import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoveAnim extends StatelessWidget {
  const LoveAnim({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
             SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                
                children: [
                  Image.network('https://media.giphy.com/media/Eman9etbqYzDLZKSxK/giphy.gif'),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text('Aww! ANIM also loves you', style: TextStyle(fontSize: 20),)

          ],
        ),
      ),
    );
  }
}