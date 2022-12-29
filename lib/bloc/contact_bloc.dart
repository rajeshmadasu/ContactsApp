import 'dart:async';
import '../models/contact.dart';
import '../repository/contact_repository.dart';

class ContactBloc {
  //Get instance of the Repository
  final _todoRepository = ContactRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _todoController = StreamController<List<Contact>>.broadcast();

  get todos => _todoController.stream;

  ContactBloc() {
    getContacts();
  }

  getContacts({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Contact todo) async {
    await _todoRepository.insertTodo(todo);
    getContacts();
  }

  updateTodo(Contact todo) async {
    await _todoRepository.updateTodo(todo);
    getContacts();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    getContacts();
  }

  dispose() {
    _todoController.close();
  }
}
