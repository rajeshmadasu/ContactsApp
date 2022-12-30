import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddContactPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Add Contact'),
    );
  }
}
