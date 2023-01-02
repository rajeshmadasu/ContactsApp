part of 'add_edit_contact_bloc.dart';

abstract class AddEditContactEvent extends Equatable {
  const AddEditContactEvent();

  @override
  List<Object> get props => [];
}

class SaveContact extends AddEditContactEvent {
  Contact contact;

  SaveContact(this.contact);

  @override
  List<Object> get props => [contact];
}
