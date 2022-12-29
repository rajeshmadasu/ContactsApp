import 'package:contactsapp/models/contact.dart';
import '../database/contact_database.dart';

class ContactDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createTodo(Contact contact) async {
    final db = await dbProvider.database;
    var result = db.insert(contactTABLE, contact.toDatabaseMap());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Contact>> getTodos({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>>? result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(contactTABLE,
            columns: columns, where: 'name LIKE ?', whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(contactTABLE, columns: columns);
    }

    List<Contact> contacts = result!.isNotEmpty
        ? result.map((item) => Contact.fromDatabaseJson(item)).toList()
        : [];
    return contacts;
  }

  //Update Todo record
  Future<int> updateTodo(Contact contact) async {
    final db = await dbProvider.database;

    var result = await db.update(contactTABLE, contact.toDatabaseMap(),
        where: "id = ?", whereArgs: [contact.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(contactTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      contactTABLE,
    );

    return result;
  }
}
