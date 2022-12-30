import 'package:flutter/material.dart';

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
                    leading: const Icon(Icons.contact_page),
                    title: const Text('Contact list'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, "/contactlist");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorite contacts'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, "/contactsfavlist");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add New Contact'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, "/addcontact");
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
