import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'views/home_page.dart';
import 'views/add_notes_page.dart';
import 'views/edit_notes_page.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
    
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: HomePage(),
      routes: {
        "addnotes": (context) => AddNotesPage(),
        "editnotes": (context) => EditNotesPage(),
      },
    );
  }
}
