part of 'contact_bloc.dart';

enum ContactStatus { initial, success, error, loading, selected }

extension ContactStatusX on ContactStatus {
  bool get isInitial => this == ContactStatus.initial;
  bool get isSuccess => this == ContactStatus.success;
  bool get isError => this == ContactStatus.error;
  bool get isLoading => this == ContactStatus.loading;
  bool get isSelected => this == ContactStatus.selected;
}

class ContactState extends Equatable {
  const ContactState({
    this.status = ContactStatus.initial,
    List<Contact>? contacts,
    int idSelected = 0,
  })  : contacts = contacts ?? const [],
        idSelected = idSelected;

  final List<Contact> contacts;
  final ContactStatus status;
  final int idSelected;

  @override
  List<Object?> get props => [status, contacts, idSelected];

  ContactState copyWith({
    List<Contact>? contacts,
    ContactStatus? status,
    int? idSelected,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      status: status ?? this.status,
      idSelected: idSelected ?? this.idSelected,
    );
  }
}
