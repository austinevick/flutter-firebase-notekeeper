import 'package:flutter/material.dart';
import 'package:flutter_notekeeper/model/note_notifier.dart';
import 'package:provider/provider.dart';

import 'screens/note_page.dart';

void main() => runApp(ChangeNotifierProvider(create: (_)=>NoteNotifier(),
  child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: NotePage(),
    );
  }
}
