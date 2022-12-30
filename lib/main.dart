// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:ui';

import 'package:contactsapp/database/contact_database.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized(); //<----FIX THE PROBLEM

  runApp(MyHomePage(
    title: "Contacts",
    databaseProvider: DatabaseProvider(),
  ));
}
