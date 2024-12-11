import 'package:organiser_app/models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';
import '../utils/constants.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._cunstructor();

  DatabaseService._cunstructor();

  final String _notesTableName = "notes";
  final String _categoriesTableName = "categories";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final String databaseDirpath = await getDatabasesPath();
    final String dbpath = join(databaseDirpath, 'organiser_db.db');
    final Database database =
        await openDatabase(dbpath, version: 1, onCreate: (db, version) async {
      // Create the `notes` table
      await db.execute(
        '''
    CREATE TABLE $_notesTableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      categoryId INTEGER,
      title TEXT,
      description TEXT,
      createdAt TEXT,
      updatedAt TEXT
    )
    ''',
      );

      // Create the `categories` table
      await db.execute(
        '''
    CREATE TABLE $_categoriesTableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      taskCount INTEGER
    )
    ''',
      );

      for (String category in categories) {
        await db.insert(_categoriesTableName, {
          'name': category,
          'taskCount': 0,
        });
      }
    });

    return database;
  }

  Future<List<Category>> getAllCategories() async {
    final Database db = await database;
    final List<Map<String, dynamic>> categories =
        await db.query(_categoriesTableName, orderBy: 'taskCount DESC');
    return List.generate(categories.length, (index) {
      return Category(
        id: categories[index]['id'],
        name: categories[index]['name'],
        taskCount: categories[index]['taskCount'],
      );
    });
  }

  Future<void> incrementTaskCount(int categoryId) async {
    final Database db = await database;
    await db.rawUpdate(
      '''
    UPDATE $_categoriesTableName
    SET taskCount = taskCount + 1
    WHERE id = ?
    ''',
      [categoryId],
    );
  }

  void addNote({
    required int categoryid,
    required String title,
    required String description,
  }) async {
    final Database db = await database;
    await db.insert(
      _notesTableName,
      {
        'categoryId': categoryid,
        'title': title,
        'description': description,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
    );
    await db.rawUpdate(
      '''
    UPDATE $_categoriesTableName
    SET taskCount = taskCount + 1
    WHERE id = ?
    ''',
      [categoryid],
    );
  }

  Future<List<Note>> getNotes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> notes =
        await db.query(_notesTableName, orderBy: 'updatedAt DESC');
    // print(notes);
    return List.generate(notes.length, (index) {
      return Note(
        id: notes[index]['id'],
        categoryId: notes[index]['categoryId'],
        title: notes[index]['title'],
        description: notes[index]['description'],
        createdAt: DateTime.parse(notes[index]['createdAt']),
        updatedAt: DateTime.parse(notes[index]['updatedAt']),
      );
    });
  }
}
