import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testtodolist/services/notes_services.dart';
import 'package:testtodolist/views/notes_list.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesServices());
}

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotesList(),
    );
  }
}
