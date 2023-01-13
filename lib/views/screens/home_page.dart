import 'package:contactsapp/repository/contact_repository.dart';
import 'package:contactsapp/views/widgets/contact_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_contact.dart';
import '../../bloc/contact_bloc.dart';
import '../widgets/error_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.contactRepository});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => MyHomePage(contactRepository: ContactRepository()));
  }

  final ContactRepository contactRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: contactRepository,
        child: BlocProvider<ContactBloc>(
          create: (context) =>
              (ContactBloc(contactRepository: contactRepository)
                ..add(GetContacts())),
          child: const Scaffold(
            body: Center(
              child: ContactList(),
            ),
          ),
        ));
  }
}

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late ContactBloc contactBloc;

  String title = "Contacts";

  void setAppBarTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  Widget getNavDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: ListView(
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 99, 27),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        'Contacts App',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_page),
                    title: const Text(
                      'Contacts List',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setAppBarTitle("Contacts");
                      BlocProvider.of<ContactBloc>(context).add(GetContacts());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Favorite contacts'),
                    onTap: () {
                      Navigator.pop(context);
                      setAppBarTitle("Favorite Contacts");
                      BlocProvider.of<ContactBloc>(context)
                          .add(GetFavContacts());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add New Contact'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddEditContactPage(
                                    contact: null,
                                    title: 'Add Contact',
                                  ))).then((value) => {
                            //refreshPage(value)
                            BlocProvider.of<ContactBloc>(context)
                                .add(GetContacts())
                          });
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactsList() =>
      BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
        if (state.status == ContactStatus.success) {
          return state.contacts.isEmpty
              ? const Center(child: Text("No Contacts found"))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    state.contacts.sort((a, b) => a.name.compareTo(b.name));
                    return ContactListItem(state.contacts[index]);
                  },
                  itemCount: state.contacts.length,
                );
        }
        if (state.status == ContactStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const ErrorTodoWidget();
        }
      });

  @override
  Widget build(BuildContext context) {
    contactBloc = BlocProvider.of<ContactBloc>(context);
    return Scaffold(
      drawer: getNavDrawer(context),
      appBar: AppBar(title: Text(title)),
      body: contactsList(),
      floatingActionButton: title.contains("Favorite")
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEditContactPage(
                            contact: null,
                            title: 'Add Contact',
                          )),
                ).then((value) => {contactBloc.add(GetContacts())})
              },
            ),
    );
  }
}
