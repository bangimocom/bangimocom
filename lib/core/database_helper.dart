
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final databaseName = "engdb.db";
  static final _databaseVersion = 1;

  static final table = 'videos';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnid = 'id';
  static final columnpath = 'path';


  static final table_reqs = 'reqs';

  static final columntype = 'type';
  static final columncontent= 'content';
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    print('db_path= '+path);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate, );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnid TEXT NOT NULL,
            $columnpath TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $table_reqs (
            $columnId INTEGER PRIMARY KEY,
            $columntype TEXT NOT NULL,
            $columncontent INTEGER NOT NULL 
          )
          ''');
  }


}
