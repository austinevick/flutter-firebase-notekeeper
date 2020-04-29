import 'package:flutter/material.dart';
import 'package:flutter_notekeeper/model/note_notifier.dart';
import 'package:flutter_notekeeper/screens/add_note_page.dart';
import 'package:provider/provider.dart';

class NoteDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000044),
        title: Text(noteNotifier.note.title),
      ),
      backgroundColor: const Color(0xff000044),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                noteNotifier.note.timeCreated,
                style: Theme.of(context).textTheme.subtitle,
              ),
             
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(noteNotifier.note.noteBody,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            )),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff000044),
        onPressed: () {
         noteNotifier.note = noteNotifier.note;
         
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddNotePage(isUpdating: true,);
          }));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
