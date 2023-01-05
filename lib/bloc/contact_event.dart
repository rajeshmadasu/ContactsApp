part of 'contact_bloc.dart';

class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetContacts extends ContactEvent {}

class GetFavContacts extends ContactEvent {}

class DeleteContact extends ContactEvent {
  int contactId;
  DeleteContact({required this.contactId});
  @override
  List<Object> get props => [contactId];
}

class UpdateContact extends ContactEvent {
  Contact contact;
  UpdateContact({required this.contact});
  @override
  List<Object?> get props => [contact];
}

class SelectTodo extends ContactEvent {
  SelectTodo({
    required this.idSelected,
  });
  final int idSelected;

  @override
  List<Object?> get props => [idSelected];
}
