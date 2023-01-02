part of 'add_edit_contact_bloc.dart';

enum AddEditContactStatus {
  initial,
  success,
  error,
  loading,
  selected,
  isSubmissionInProgress
}

extension AddEditContactStatusX on AddEditContactStatus {
  bool get isInitial => this == AddEditContactStatus.initial;
  bool get isSuccess => this == AddEditContactStatus.success;
  bool get isError => this == AddEditContactStatus.error;
  bool get isLoading => this == AddEditContactStatus.loading;
  bool get isSelected => this == AddEditContactStatus.selected;
  bool get isSubmissionInProgress =>
      this == AddEditContactStatus.isSubmissionInProgress;
}

class AddEditContactState extends Equatable {
  AddEditContactState(this.status);

  // late Contact? contact;
  final AddEditContactStatus status;

  AddEditContactState addContact(status) {
//    var uuid = const Uuid();

    return AddEditContactState(status);
  }

  @override
  List<Object> get props => [status];
}
