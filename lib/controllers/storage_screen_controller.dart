import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';

class StorageScreenController extends GetxController{

  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxInt size = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getStorage();
  }

  void getStorage() {
    size.bindStream(
      userCollection.doc(uid).collection('files').snapshots().map(
        (QuerySnapshot querySnapshot){
          int size = 0;
          querySnapshot.docs.forEach((element) {
            size += extractSize(element);
          });
          return size;
        }
      )
    );
  }

  int extractSize(QueryDocumentSnapshot<Object?> element){
    return element['size'];
  }
}