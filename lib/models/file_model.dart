import 'package:cloud_firestore/cloud_firestore.dart';

class FileModel{
  late String id;
  late String url;
  late String name;
  late Timestamp uploadTime;
  late String type;
  late String ext;
  late String folder;
  late int size;

  FileModel(this.id, this.url, this.name, this.uploadTime, this.type,
      this.ext, this.folder, this.size);

  FileModel.fromJson(QueryDocumentSnapshot<Object?> snapshot){
    id = snapshot.id;
    url = snapshot['fileUrl'];
    name = snapshot['fileName'];
    uploadTime = snapshot['dateUploaded'];
    type = snapshot['fileType'];
    ext = snapshot['fileExtension'];
    folder = snapshot['folder'];
    size = snapshot['size'];
  }
}