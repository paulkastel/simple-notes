import 'package:flutter/material.dart';

import 'screens/add_note_screen.dart';
import 'screens/home_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const SimpleNotesApp());
}

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.addNoteScreen:
            return MaterialPageRoute(builder: (context) => const AddNoteProvider());
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const HomeProvider());
      },
      home: const HomeProvider(),
    );
  }
}
