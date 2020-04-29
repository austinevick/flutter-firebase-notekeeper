import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notekeeper/model/note.dart';
import 'package:flutter_notekeeper/model/note_notifier.dart';
import 'package:intl/intl.dart';


  addNote(Note note)async{
   CollectionReference collectionReference = Firestore.instance.collection('note');
      note.timeCreated = DateFormat('dd,MMM,yyyy kk:mm').format(DateTime.now());
         DocumentReference documentReference = await collectionReference.add(note.toMap());
         note.id = documentReference.documentID;
         print(note.timeCreated);
         await documentReference.setData(note.toMap(),merge: true);
       }
  

  updateNote(Note note)async{
CollectionReference collectionReference = Firestore.instance.collection('note');

 note.timeUpdated = DateFormat.yMMMd().format(DateTime.now());

await collectionReference.document(note.id).updateData(note.toMap());
         }


   getNote(NoteNotifier noteNotifier) async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('note').getDocuments();
    List<Note> _noteList = [];
    querySnapshot.documents.forEach((doc) {
      Note note = Note.fromMap(doc.data);
      _noteList.add(note);
    });
    noteNotifier.noteList = _noteList;
  }
  deleteNote(Note note,Function noteDeleted)async{
  await  Firestore.instance.collection('note').document(note.id).delete();
    noteDeleted(note);
  }
