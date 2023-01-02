import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const contactTABLE = 'contacts';

//This class manages creating the database schema
//and expose the database instance Asynchronously for ContactDao to call
class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {}
    _database = await createDatabase();
    return _database!;
  }

  createDatabase() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // //"ContactsDB.db is our database instance name
    // String path = join(documentsDirectory.path, "Contactsdb.db");
    // var database = await openDatabase(path,
    //     version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    // return database;

// Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    Database db = await openDatabase(join(databasesPath, 'mycontacts.db'),
        version: 1, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("CREATE TABLE $contactTABLE("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
          "name TEXT, "
          "mobile_number TEXT, "
          "landline_number TEXT, "
          "image TEXT, "
          "favourite int "
          ")");
    });

    return db;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $contactTABLE ("
        "id TEXT PRIMARY KEY, "
        "name TEXT, "
        "mobile_number TEXT, "
        "landline_number TEXT, "
        "image TEXT, "
        "favourite BOOLEAN, "
        ")");
  }
}
