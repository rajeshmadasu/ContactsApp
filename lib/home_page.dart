import 'package:contactsapp/database/contact_database.dart';
import 'package:contactsapp/navigation/app_drawer.dart';
import 'package:contactsapp/views/add_contact_widget/add_contact.dart';
import 'package:contactsapp/views/contact_list.dart';
import 'package:contactsapp/views/contact_list_old.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.databaseProvider});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) =>
            MyHomePage(title: '', databaseProvider: DatabaseProvider()));
  }

  final String title;
  final DatabaseProvider databaseProvider;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.databaseProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: ContactList(isFromFav: false),
        ),
        drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddContactPage()),
            )
          },
        ),
      ),
    );
  }
}
