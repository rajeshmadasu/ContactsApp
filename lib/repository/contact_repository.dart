import 'package:contactsapp/models/contact.dart';
import '../dao/contact_dao.dart';

class ContactRepository {
  final contactDao = ContactDao();

  Future getAllTodos({String? query}) => contactDao.getTodos(query: query);

  Future insertTodo(Contact todo) => contactDao.createTodo(todo);

  Future updateTodo(Contact todo) => contactDao.updateTodo(todo);

  Future deleteTodoById(int id) => contactDao.deleteTodo(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() => contactDao.deleteAllTodos();
}
