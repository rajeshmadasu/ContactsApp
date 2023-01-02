import '../views/add_contact_widget/add_contact.dart';
import 'package:flutter/material.dart';

import '../views/contact_list.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
                                  )));
                      // Navigator.pushNamed(context, "/contactsfavlist");
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
                              builder: (context) => AddContactPage()));
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
