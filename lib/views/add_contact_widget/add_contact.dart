import '../add_contact_widget/add_contact_view.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddContactPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add Contact')),
        body: const Padding(
          padding: EdgeInsets.all(12),
          child: AddContactPage(),
        ));
  }
}
