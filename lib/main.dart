import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/pages/ToDoList.dart';
import 'package:notes/pages/createnotes/love_anim.dart';
import 'package:notes/pages/createnotes/note_page.dart';

import 'components/navbar.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ANIM'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/':(context) => const MyApp(),
        '/todo-list': (context) => ToDoList(),
        '/create-list':(context) => NotePage(),
        '/love-anim':(context)=> LoveAnim()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{},
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.add),
        ),
          );
  }
}
