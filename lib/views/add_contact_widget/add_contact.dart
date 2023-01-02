import 'package:contactsapp/views/add_contact_widget/bloc/add_edit_contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_contact_widget/add_contact_view.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddContactPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return AddEditContactBloc();
          },
          child: const AddContactView(),
        ),
      ),
    );
  }
}
