part of 'appdrawer_bloc.dart';

abstract class AppDrawerEvent extends Equatable {
  const AppDrawerEvent();
  @override
  List<Object> get props => [];
}

class ContactsEvent extends AppDrawerEvent {}

class FavouriteContactsEvent extends AppDrawerEvent {}

class AddContactEvent extends AppDrawerEvent {}
