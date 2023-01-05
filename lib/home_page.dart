import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './database/contact_database.dart';
import './views/add_contact_widget/add_contact.dart';
import 'bloc/contact_bloc.dart';
import 'views/error_widget.dart';

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

  void refreshPage(value) {
    if (value != null && value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: "Contacts",
            databaseProvider: DatabaseProvider(),
          ),
        ),
      );
    }
  }

  Widget displayContactList() {
    return Center(
      child: ContactList(
          isFromFav: false,
          title: "Contacts",
          isFromHome: true,
          refreshPage: refreshPage),
    );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactList(
                                  isFromFav: false,
                                  title: "Contacts",
                                  isFromHome: false,
                                  refreshPage: () {})));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorite contacts'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactList(
                              isFromFav: true,
                              title: "Favorite Contacts",
                              isFromHome: false,
                              refreshPage: () {}),
                        ),
                      );
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
                              builder: (context) => const AddContactPage(
                                    contact: null,
                                    title: 'Add Contact',
                                  ))).then((value) => {refreshPage(value)});
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

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.databaseProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: displayContactList(),
        drawer: getNavDrawer(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddContactPage(
                        contact: null,
                        title: 'Add Contact',
                      )),
            ).then((value) => {refreshPage(value)})
          },
        ),
      ),
    );
  }
}

class ContactList extends StatefulWidget {
  bool isFromFav;
  bool isFromHome;
  String title;
  Function refreshPage;
  ContactList({
    super.key,
    required this.isFromFav,
    required this.title,
    required this.isFromHome,
    required this.refreshPage,
  });
  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => ContactList(
              isFromFav: false,
              title: "Contacts",
              isFromHome: true,
              refreshPage: () {},
            ));
  }

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Widget contactsList(Function refreshPage) =>
      BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
        return state.status.isSuccess
            ? state.contacts.isEmpty
                ? const Center(child: Text("No Contacts found"))
                : ListView.builder(
                    itemBuilder: (context, index) {
                      state.contacts.sort((a, b) => a.name.compareTo(b.name));
                      return Card(
                        elevation: 5,
                        child: Dismissible(
                          key: ValueKey(state.contacts[index].id),
                          background: Container(
                            color: Colors.red,
                            // ignore: sort_child_properties_last
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            alignment: Alignment.centerRight,
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            context.read<ContactBloc>().add((DeleteContact(
                                contactId: state.contacts[index].id)));
                          },
                          child: ListTile(
                              leading: state.contacts[index].image.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 26,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          child: Image.file(
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                              File(state.contacts[index].image
                                                  .toString()))))
                                  : CircleAvatar(
                                      radius: 26,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          child: Image.asset(
                                            'assets/images/add_image.png',
                                            width: 60,
                                            height: 60,
                                          ))),
                              title: Text(
                                state.contacts[index].name.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${state.contacts[index].mobileNumber}\n${state.contacts[index].landlineNumber}',
                              ),
                              isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddContactPage(
                                            contact: state.contacts[index],
                                            title: 'Update Contact',
                                          )),
                                ).then((value) => {refreshPage(value)});
                              },
                              trailing: GestureDetector(
                                  onTap: (() {
                                    context.read<ContactBloc>().add(
                                        (UpdateContact(
                                            contact: state.contacts[index])));

                                    //  updateFav(state.contacts![index]);
                                  }),
                                  child: state.contacts[index].favourite == 1
                                      ? const Icon(
                                          Icons.star,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.star,
                                        ))),
                        ),
                      );
                    },
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

  Widget buildContactList() => BlocProvider<ContactBloc>(
      create: (context) => widget.isFromFav
          ? (ContactBloc()..add(GetFavContacts()))
          : (ContactBloc()..add(GetContacts())),
      child: widget.isFromHome
          ? contactsList(widget.refreshPage)
          : Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              body: contactsList(widget.refreshPage)));

  @override
  Widget build(BuildContext context) {
    return buildContactList();
  }
}
