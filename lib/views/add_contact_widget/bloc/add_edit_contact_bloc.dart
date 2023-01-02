import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/contact.dart';
import '../../../repository/contact_repository.dart';

part 'add_edit_contact_event.dart';
part 'add_edit_contact_state.dart';

class AddEditContactBloc
    extends Bloc<AddEditContactEvent, AddEditContactState> {
  AddEditContactBloc()
      : super(AddEditContactState(AddEditContactStatus.initial)) {
    on<SaveContact>(_onSaveSubmitted);
  }
  final _contactRepository = ContactRepository();

  Future<void> _onSaveSubmitted(
    SaveContact event,
    Emitter<AddEditContactState> emit,
  ) async {
    emit(state.addContact(AddEditContactStatus.loading));
    try {
      await _contactRepository.insertContact(event.contact).then((value) {
        if (value != 0) {
          emit(state.addContact(AddEditContactStatus.success));
          _contactRepository.getAllContacts();
        } else {
          emit(state.addContact((AddEditContactStatus.error)));
        }
      });
    } catch (_) {
      emit(state.addContact((AddEditContactStatus.error)));
    }
  }
}
