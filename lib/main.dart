// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:ui';

import 'package:contactsapp/database/contact_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

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
        title: "Contacts",
        databaseProvider: DatabaseProvider(),
      )));
}
