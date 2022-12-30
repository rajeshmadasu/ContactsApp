import 'package:contactsapp/database/contact_database.dart';
import 'package:contactsapp/navigation/app_drawer.dart';
import 'package:contactsapp/views/add_contact_widget/add_contact.dart';
import 'package:contactsapp/views/contact_favourites.dart';
import 'package:contactsapp/views/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title, required this.databaseProvider});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => MyHomePage(title: '', databaseProvider: null));
  }

  final String title;
  final DatabaseProvider? databaseProvider;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: databaseProvider,
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            // Here you define the names and the Widgets (Preferably ones with a Scaffold) that are your pages
            '/contactlist': (context) => const ContactList(),
            '/contactsfavlist': (context) => const ContactFavList(),
            '/addcontact': (context) => const AddContactPage(),
          },
          home: Scaffold(
              appBar: AppBar(title: Text(title)),
              body: const Center(
                child: ContactList(),
              ),
              drawer: AppDrawer()),
        ));
  }
}
