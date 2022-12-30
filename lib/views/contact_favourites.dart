import 'package:flutter/material.dart';

class ContactFavList extends StatelessWidget {
  const ContactFavList({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ContactFavList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Contacts Fav List'),
    );
  }
}
