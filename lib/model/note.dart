
class Note {
  String id;
  String title;
  String timeCreated;
  String noteBody;
  String timeUpdated;

  Note({this.id, this.title,this.timeCreated,this.noteBody,this.timeUpdated});

  Map<String, dynamic> toMap() {
    return {'id':id, 'title': title, 'timeCreated': timeCreated,'noteBody':noteBody,'timeUpdated':timeUpdated};
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    timeCreated = map['timeCreated'];
    timeUpdated = map['timeUpdated'];
    noteBody = map['noteBody'];
  }
}
