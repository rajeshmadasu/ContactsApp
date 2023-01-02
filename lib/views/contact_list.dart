import 'dart:io';

import 'package:contactsapp/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_widget.dart';

class ContactList extends StatefulWidget {
  bool isFromFav;

  ContactList({super.key, required this.isFromFav});
  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => ContactList(
              isFromFav: false,
            ));
  }

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Widget contactsList =
      BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
    return state.status.isSuccess
        ? ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                    leading: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.file(
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                File(state.contacts[index].image.toString())))),
                    title: Text(
                      state.contacts[index].name.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${state.contacts[index].mobileNumber}"\n"${state.contacts[index].landlineNumber}',
                    ),
                    isThreeLine: true,
                    onTap: () {},
                    trailing: GestureDetector(
                        onTap: (() {
                          context.read<ContactBloc>().add(
                              (UpdateContact(contact: state.contacts[index])));

                          //  updateFav(state.contacts![index]);
                        }),
                        child: state.contacts[index].favourite == 1
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite,
                              ))),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              width: 16.0,
            ),
            itemCount: state.contacts.length,
          )
        : state.status.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.status.isError
                ? const ErrorTodoWidget()
                : const SizedBox();
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactBloc>(
        create: (context) => widget.isFromFav
            ? (ContactBloc()..add(GetFavContacts()))
            : (ContactBloc()..add(GetContacts())),
        child: widget.isFromFav
            ? Scaffold(
                appBar: AppBar(title: const Text('Favourite Contacts')),
                body: contactsList)
            : contactsList);
  }
}
