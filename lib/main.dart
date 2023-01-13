import 'dart:ui';

import 'package:contactsapp/repository/contact_repository.dart';
import 'package:flutter/material.dart';

import 'views/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  runApp(MaterialApp(
      // to hide debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.amber[900], error: Colors.red)
            .copyWith(secondary: Colors.deepOrange),
      ),
      home: MyHomePage(
        contactRepository: ContactRepository(),
      )));
}
