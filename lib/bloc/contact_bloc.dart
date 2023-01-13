import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact.dart';
import '../repository/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  //Get instance of the Repository
  final ContactRepository contactRepository;

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _contactController = StreamController<List<Contact>>.broadcast();

  get allContacts => _contactController.stream;

  ContactBloc({required this.contactRepository}) : super(ContactState()) {
    on<GetContacts>(getContacts);
    on<GetFavContacts>(getFavContacts);
    on<UpdateContact>(updateContactAsFav);
    on<DeleteContact>(deleteContactById);
  }

  getFavContacts(GetFavContacts event, Emitter<ContactState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    try {
      final contacts = await contactRepository.getAllFavContacts();
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
    emit(state.copyWith(status: ContactStatus.loading));
    try {
      final contacts = await contactRepository.getAllContacts();
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

  addContact(Contact contact) async {
    await contactRepository.insertContact(contact);
  }

  updateContactAsFav(UpdateContact event, Emitter<ContactState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));
    Contact updateContact = event.contact;
    updateContact.favourite = event.contact.favourite == 1 ? 0 : 1;
    await contactRepository.updateContact(updateContact);

    try {
      final contacts = await contactRepository.getAllContacts();
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

  deleteContactById(DeleteContact event, Emitter<ContactState> emit) async {
    emit(state.copyWith(status: ContactStatus.loading));

    final response = await contactRepository.deleteContactById(event.contactId);
    try {
      if (response == 1) {
        final contacts = await contactRepository.getAllContacts();
        emit(
          state.copyWith(
            status: ContactStatus.success,
            contacts: contacts,
          ),
        );
      } else {
        emit(state.copyWith(status: ContactStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: ContactStatus.error));
    }
  }

  dispose() {
    _contactController.close();
  }
}
