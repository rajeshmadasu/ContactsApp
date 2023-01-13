import 'package:contactsapp/models/contact.dart';
import 'package:contactsapp/views/add_contact_widget/bloc/add_edit_contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_contact_view.dart';
import 'package:flutter/material.dart';

class AddEditContactPage extends StatefulWidget {
  final Contact? contact;
  final String title;
  const AddEditContactPage({
    super.key,
    required this.contact,
    required this.title,
  });

  @override
  State<AddEditContactPage> createState() => _AddEditContactPageState();
}

class _AddEditContactPageState extends State<AddEditContactPage> {
  bool isFavoriteSelected = false;

  void updateFav() {
    setState(() {
      isFavoriteSelected = !isFavoriteSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      widget.contact!.favourite == 1
          ? isFavoriteSelected = true
          : isFavoriteSelected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: isFavoriteSelected
                ? Icon(Icons.star, color: Colors.green[900])
                : const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
            onPressed: updateFav,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return AddEditContactBloc();
          },
          child: AddContactView(widget.contact, isFavoriteSelected),
        ),
      ),
    );
  }
}
