import '../home_page.dart';
import '../views/add_contact_widget/add_contact.dart';
import 'package:flutter/material.dart';

import '../views/contact_list.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool refreshData = false;

  void updateData() {
    setState(() {
      refreshData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Contacts App',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_page),
                    title: const Text('Contacts List'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactList(
                                    isFromFav: false,
                                    title: "Contacts",
                                    isFromHome: false,
                                    refreshPage: () {},
                                  )));

                      // Navigator.pushNamed(context, "/contactsfavlist");
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
                                  refreshPage: () {})));

                      // Navigator.pushNamed(context, "/contactsfavlist");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add New Contact'),
                    onTap: () {
                      Navigator.pop(context);
                      var refresh = Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddContactPage(
                                    title: "Add Contact",
                                    contact: null,
                                  )));
                      if (refresh == 'refresh') {
                        updateData();
                      }

                      // Navigator.pushNamed(context, "/addcontact");
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
}
