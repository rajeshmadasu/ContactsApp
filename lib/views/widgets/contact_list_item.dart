import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/contact_bloc.dart';
import '../../models/contact.dart';
import '../screens/add_edit_contact.dart';

class ContactListItem extends StatelessWidget {
  final Contact _contact;

  const ContactListItem(this._contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Dismissible(
        key: ValueKey(_contact.id),
        background: Container(
          color: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context
              .read<ContactBloc>()
              .add((DeleteContact(contactId: _contact.id)));
        },
        child: ListTile(
            leading: _contact.image.isNotEmpty
                ? CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image.file(
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            File(_contact.image.toString()))))
                : CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image.asset(
                          'assets/images/add_image.png',
                          width: 60,
                          height: 60,
                        ))),
            title: Text(
              _contact.name.toString(),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${_contact.mobileNumber}\n${_contact.landlineNumber}',
            ),
            isThreeLine: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEditContactPage(
                          contact: _contact,
                          title: 'Update Contact',
                        )),
              ).then((value) =>
                  {context.read<ContactBloc>().add((GetContacts()))});
            },
            trailing: GestureDetector(
                onTap: (() {
                  context
                      .read<ContactBloc>()
                      .add((UpdateContact(contact: _contact)));
                }),
                child: _contact.favourite == 1
                    ? const Icon(
                        Icons.star,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.star,
                      ))),
      ),
    );
  }
}
