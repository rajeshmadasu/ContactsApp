import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const contactTABLE = 'contacts';

//This class manages creating the database schema
//and expose the database instance Asynchronously for ContactDao to call
class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ContactsDB.db is our database instance name
    String path = join(documentsDirectory.path, "ContactsDB.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $contactTABLE ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "mobile_number TEXT, "
        "landline_number TEXT, "
        "image TEXT, "
        ")");
  }
}
