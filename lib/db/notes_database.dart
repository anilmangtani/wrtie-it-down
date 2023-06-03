import 'package:notes/model/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase{
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();
  
  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('notes.db');
    return database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  //Database Scehma method
  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final numberType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableNotes(
        ${NoteFields.id} $idType,
        ${NoteFields.isImportant} $boolType,
        ${NoteFields.number} $numberType,
        ${NoteFields.title} $textType,
        ${NoteFields.description} $textType,
        ${NoteFields.time} $textType

      )
''');
  }

  // method for creating
  Future<Note> create(Note note)async{
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id:id);
  }

  //to read single note
  Future<Note> readNote(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id]
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }
  }


  //to read all notes
  Future<List<Note>> readAll() async{
    final db = await instance.database;
    final orderBy = '${NoteFields.time} ASC';
    final result = await db.query(tableNotes, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  //to update the notes
  Future<int> update(Note note) async{
    final db = await instance.database;
    return db.update(
      tableNotes, 
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id]);
  }

  //to delete the note
  Future<int> delete(int id) async{
    final db = await instance.database;
    return await db.delete(tableNotes,
    where: '${NoteFields.id} = ?',
    whereArgs: [id]);
  }

  //method to close db
  Future close() async{
    final db = await instance.database;
    db.close();
  }
}