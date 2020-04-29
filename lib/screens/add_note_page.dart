import 'package:flutter/material.dart';
import 'package:flutter_notekeeper/database/note_db.dart';
import 'package:flutter_notekeeper/model/note.dart';
import 'package:flutter_notekeeper/model/note_notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  final bool isUpdating;

  const AddNotePage({Key key, this.isUpdating}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteBodyController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  saveNote() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Note note = new Note(
          title: titleController.text, noteBody: noteBodyController.text);
      addNote(note);
    } else {
      Note note = new Note(
          title: titleController.text, 
          noteBody: noteBodyController.text);
      updateNote(note);
    }
  }

  @override
  void initState() {
    noteUpdate();
    super.initState();
  }

  noteUpdate() {
    NoteNotifier note = Provider.of<NoteNotifier>(context, listen: false);

    if (widget.isUpdating) {
      setState(() {
        note.note.title = titleController.text;
        note.note.noteBody = noteBodyController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    NoteNotifier noteNotifier = Provider.of<NoteNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000044),
        title: Text('Add Note'),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // initialValue: noteNotifier.note.title,
                        controller: titleController,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        //initialValue: noteNotifier.note.noteBody,
                        maxLines: 100,
                        validator: (value) {
                          if (value.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Text must not be null');
                            return '';
                          }
                          return null;
                        },
                        controller: noteBodyController,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your note here'),
                      ),
                    ),
                  ],
                ))),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff000044),
        onPressed: () async {
          saveNote();
          getNote(noteNotifier);
          Navigator.pop(context);
        },
        child: Icon(
          Icons.done,
          size: 30,
        ),
      ),
    );
  }
}
