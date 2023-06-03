import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          
          UserAccountsDrawerHeader(
            accountName: const Text('ANIM'),
            accountEmail: const Text("animraps@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network('https://media.giphy.com/media/3o7abKhOpu0NwenH3O/giphy.gif', height: 90, width: 90, fit:BoxFit.cover,),
              )
              
              ),
            )
          ,
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Create new Note'),
            onTap: ()=> Navigator.pushNamed(context, '/create-list'),
          ),
          ListTile(
            leading: const Icon(Icons.toys_rounded),
            title: const Text('To-Do List'),
            onTap: ()=> Navigator.pushNamed(context, '/todo-list'),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Importants'),
            onTap: ()=> null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Invite people'),
            onTap: ()=> null,
          ),
          ListTile(
            leading: const Icon(Icons.coffee),
            title: const Text('Features'),
            onTap: ()=> null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('You love ANIM'),
            onTap: ()=> Navigator.pushNamed(context, '/love-anim'),
          ),
        ],
      ),
    );
  }
}