import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/models/file_model.dart';

class FilesDisplayController extends GetxController{
  final String type;
  final String folderName;
  final String fileType;

  FilesDisplayController(this.type, this.folderName, this.fileType);

  String uid = FirebaseAuth.instance.currentUser!.uid;

  RxList<FileModel> files = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if(type == 'files'){
      files.bindStream(userCollection.doc(uid).collection('files').where('fileType',
          isEqualTo: fileType).snapshots().map((QuerySnapshot querySnapshot){
            List<FileModel> tempFiles = [];
            List<QueryDocumentSnapshot<Object?>> docList = querySnapshot.docs;
            docList.forEach((element) {
              tempFiles.add(FileModel.fromJson(element));
            });
            return tempFiles;
          }
      ));
    }
    else{
      files.bindStream(userCollection.doc(uid).collection('files').where('folder',
        isEqualTo: folderName).snapshots().map((QuerySnapshot querySnapshot){
          List<FileModel> tempFiles = [];
          querySnapshot.docs.forEach((element) {
            tempFiles.add(FileModel.fromJson(element));
          });
          return tempFiles;
      }));
    }
  }
}

class FilesBinding implements Bindings{

  final String type;
  final String folderName;
  final String fileType;

  FilesBinding(this.type, this.folderName, this.fileType);

  @override
  void dependencies() {
    Get.lazyPut(() => FilesDisplayController(type, this.folderName, fileType));
  }
}