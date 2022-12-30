import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contactsapp/navigation/app_drawer.dart';
import 'package:equatable/equatable.dart';

part 'appdrawer_event.dart';
part 'appdrawer_state.dart';

class AppdrawerBloc extends Bloc<AppDrawerEvent, AppDrawerState> {
  AppdrawerBloc() : super(AppDrawerState.allContacts) {
    //on<AppDrawerEvent>(() => mapEventToState(FavouriteContactsEvent()));
  }

  Stream<AppDrawerState> mapEventToState(
    AppDrawerEvent event,
  ) async* {
    if (event is ContactsEvent) {
      yield AppDrawerState.allContacts;
    } else if (event is FavouriteContactsEvent) {
      yield AppDrawerState.favouriteContacts;
    } else if (event is AddContactEvent) {
      yield AppDrawerState.addContact;
    }
  }
}
