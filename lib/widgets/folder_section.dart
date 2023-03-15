import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/files_display_controller.dart';
import 'package:google_drive_clone/controllers/files_screen_controller.dart';
import 'package:google_drive_clone/screens/display_files_screen.dart';

class FolderSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetX<FilesScreenController>(
      builder: (FilesScreenController folderController) {
        if(folderController != null && folderController.foldersList != null){
          return GridView.builder(
            itemCount: folderController.foldersList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index){
              return InkWell(
                onTap: ()=>
                  Get.to(DisplayFilesScreen(folderController.foldersList[index].name, 'folder'),
                  binding: FilesBinding('Folders', folderController.foldersList[index].name,
                      folderController.foldersList[index].name),
                  ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.0001),
                        blurRadius: 5,
                        offset: Offset(10, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 90,
                        width: 90,
                        image: AssetImage('assets/images/folder_image.png'),
                        fit: BoxFit.cover,
                      ),
                      Text(folderController.foldersList[index].name,
                        style: textStyle(18, textColor, FontWeight.bold),),
                      StreamBuilder<QuerySnapshot>(
                        stream: userCollection.doc(FirebaseAuth.instance.currentUser!.uid).
                        collection('files').where('folder', isEqualTo:
                        folderController.foldersList[index].name).snapshots(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return CircularProgressIndicator();
                          }
                          return Text('${snapshot.data!.docs.length} items',
                            style: textStyle(14, Colors.grey.shade400, FontWeight.bold),);
                        }
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}