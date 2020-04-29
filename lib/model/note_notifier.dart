import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_notekeeper/model/note.dart';

class NoteNotifier with ChangeNotifier{
  List<Note> _noteList = [];
  Note _note;

  Note get note => _note;
  UnmodifiableListView<Note> get noteList => UnmodifiableListView(_noteList); 

set noteList(List<Note> noteList){
  _noteList = noteList;
  notifyListeners();
}
set note(Note note){
  _note = note;
  notifyListeners();
}
deletedNote(Note note){
  _noteList.removeWhere((_note)=>_note.id == note.id);
  notifyListeners();
}

}