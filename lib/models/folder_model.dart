import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel{
  late String id;
  late String name;
  late Timestamp dateCreated;
  late int items;

  FolderModel(this.id, this.name, this.dateCreated, this.items);

  FolderModel.fromJson(QueryDocumentSnapshot<Object?> snapshot){
    id = snapshot.id;
    name = snapshot['name'];
    dateCreated = snapshot['time'];
  }
}