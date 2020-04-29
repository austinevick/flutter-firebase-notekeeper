import 'package:flutter/material.dart';
import 'package:flutter_notekeeper/database/note_db.dart';
import 'package:flutter_notekeeper/model/note.dart';
import 'package:flutter_notekeeper/model/note_notifier.dart';
import 'package:flutter_notekeeper/screens/note_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

import 'add_note_page.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    NoteNotifier noteNotifier =
        Provider.of<NoteNotifier>(context, listen: false);
    getNote(noteNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);
    _onNoteDeleted(Note note) {
    
      noteNotifier.deletedNote(note);
    }

    return Scaffold(
      backgroundColor: const Color(0xff000044),
      body: CustomScrollView(
        slivers: <Widget>[
          RoundedFloatingAppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.delete_sweep,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                  }),
            ],
            title: Text(
              'Notes',
              style: TextStyle(fontSize: 25),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return GestureDetector(
                onTap: () {
                  noteNotifier.note = noteNotifier.noteList[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteDetailPage()));
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            noteNotifier.noteList[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 22),
                          ),
                          SizedBox(height: 6,),
                          Text(
                            noteNotifier.noteList[index].noteBody,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          IconButton(icon: Icon(Icons.delete),
                          onPressed:()=>deleteNote(noteNotifier.noteList[index], _onNoteDeleted))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: noteNotifier.noteList.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 30,
            color: const Color(0xff000044),
          ),
          onPressed: () {
           
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => AddNotePage(isUpdating: false,)));
          }),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
