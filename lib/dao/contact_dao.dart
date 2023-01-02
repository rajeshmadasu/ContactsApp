import 'package:contactsapp/models/contact.dart';
import '../database/contact_database.dart';
import 'package:path/path.dart';

class ContactDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new contact records
  Future<int> createContact(Contact contact) async {
    final db = await dbProvider.database;
    var result = db.insert(contactTABLE, contact.toDatabaseMap());
    return result;
  }

  //Get All contact items
  //Searches if query string was passed
  Future<List<Contact>> getFavContacts() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>>? result;
    result =
        await db.query(contactTABLE, where: 'favourite = ?', whereArgs: [1]);

    List<Contact> contacts = result.isNotEmpty
        ? result.map((item) => Contact.fromDatabaseJson(item)).toList()
        : [];
    return contacts;
  }

  //Get All contact items
  //Searches if query string was passed
  Future<List<Contact>> getContacts(
      {List<String>? columns, String? query}) async {
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

  //Update Contact record
  Future<int> updateContact(Contact contact) async {
    final db = await dbProvider.database;

    var result = await db.update(contactTABLE, contact.toDatabaseMap(),
        where: "id = ?", whereArgs: [contact.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteContact(int id) async {
    final db = await dbProvider.createDatabase();
    var result =
        await db.delete(contactTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllContacts() async {
    final db = await dbProvider.createDatabase();
    var result = await db.delete(
      contactTABLE,
    );

    return result;
  }
}
