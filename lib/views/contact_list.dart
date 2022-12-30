import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ContactList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Contacts List'),
    );
  }
}
