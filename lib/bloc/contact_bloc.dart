import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact.dart';
import '../repository/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  //Get instance of the Repository
  final _contactRepository = ContactRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _contactController = StreamController<List<Contact>>.broadcast();

  get allContacts => _contactController.stream;

  ContactBloc() : super(const ContactState()) {
    on<GetContacts>(getContacts);
    on<GetFavContacts>(getFavContacts);
    on<UpdateContact>(updateContact);
  }

  getFavContacts(GetFavContacts event, Emitter<ContactState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    try {
      final contacts = await _contactRepository.getAllFavContacts();
      emit(
        state.copyWith(
          status: ContactStatus.success,
          contacts: contacts,
        ),
      );
    } catch (error, stacktrace) {
      emit(state.copyWith(status: ContactStatus.error));
    }
  }

  getContacts(GetContacts event, Emitter<ContactState> emit) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    emit(state.copyWith(status: ContactStatus.loading));
    try {
      final contacts = await _contactRepository.getAllContacts();
      emit(
        state.copyWith(
          status: ContactStatus.success,
          contacts: contacts,
        ),
      );
    } catch (error, stacktrace) {
      emit(state.copyWith(status: ContactStatus.error));
    }
    //  _contactController.sink.add(await _contactRepository.getAllContacts());
  }

//  getFavContacts({String? query}) async {
//    _contactController.sink.add(await _contactRepository.getAllFavContacts());
//  }

  addContact(Contact contact) async {
    await _contactRepository.insertContact(contact);
  }

  updateContact(UpdateContact event, Emitter<ContactState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    Contact updateContact = event.contact;
    updateContact.favourite = event.contact.favourite == 1 ? 0 : 1;
    await _contactRepository.updateContact(updateContact);

    try {
      final contacts = await _contactRepository.getAllContacts();
      emit(
        state.copyWith(
          status: ContactStatus.success,
          contacts: contacts,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ContactStatus.error));
    }
  }

  deleteContactById(int id) async {
    _contactRepository.deleteContactById(id);
  }

  dispose() {
    _contactController.close();
  }
}
