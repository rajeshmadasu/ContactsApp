import 'package:contactsapp/models/contact.dart';
import 'package:contactsapp/views/add_contact_widget/bloc/add_edit_contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_contact_widget/add_contact_view.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  final Contact? contact;
  final String title;
  const AddContactPage({
    super.key,
    required this.contact,
    required this.title,
  });

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  bool isFavEnabled = false;

  void updateFav(bool value) {
    setState(() {
      isFavEnabled = value;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      widget.contact!.favourite == 1
          ? isFavEnabled = true
          : isFavEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: isFavEnabled
                ? Icon(Icons.star, color: Colors.green[900])
                : const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
            onPressed: () {
              updateFav(!isFavEnabled);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return AddEditContactBloc();
          },
          child: AddContactView(widget.contact, isFavEnabled),
        ),
      ),
    );
  }
}
