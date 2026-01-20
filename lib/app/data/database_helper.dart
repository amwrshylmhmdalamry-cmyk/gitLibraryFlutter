import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'auth_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        name TEXT,
        createdAt TEXT
      )
    ''');

    // إضافة مستخدم افتراضي للاختبار
    await db.insert('users', {
      'email': 'suhil@example.com',
      'password': '123456',
      'name': 'suhil',
      'createdAt': DateTime.now().toString()
    });
    CollectionReference users =FirebaseFirestore.instance.collection("users");

  }

  Future<int> insertUser(UserModel user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> getUser(String email, String password) async {
    Database db = await database;
    List<Map> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> userExists(String email) async {
    Database db = await database;
    List<Map> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }
}