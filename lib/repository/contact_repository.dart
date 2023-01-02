import '../dao/contact_dao.dart';
import '../models/contact.dart';

class ContactRepository {
  final contactDao = ContactDao();

  Future getAllContacts({String? query}) =>
      contactDao.getContacts(query: query);
  Future getAllFavContacts() => contactDao.getFavContacts();
  Future insertContact(Contact contact) => contactDao.createContact(contact);

  Future updateContact(Contact contact) => contactDao.updateContact(contact);

  Future deleteContactById(int id) => contactDao.deleteContact(id);

  //We are not going to use this in the demo
  Future deleteAllContacts() => contactDao.deleteAllContacts();
}
