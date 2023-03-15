import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/files_screen_controller.dart';
import 'package:google_drive_clone/firebase_service.dart';
import 'package:google_drive_clone/screens/nav_screen.dart';
import 'package:google_drive_clone/widgets/floating_button.dart';
import 'package:google_drive_clone/widgets/folder_section.dart';
import 'package:google_drive_clone/widgets/recent_files.dart';

class FilesScreen extends StatelessWidget {

  TextEditingController createFolder = TextEditingController();
  FilesScreenController filesScreenController = Get.put(FilesScreenController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 30,bottom: 10),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  RecentFiles(),
                  FolderSection(),
              ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        builder: (context){
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: ()=> openAddFolderDialog(context),
                                    child: Row(
                                      children: [
                                        Icon(EvaIcons.folderAdd, color: Colors.grey, size: 30,),
                                        SizedBox(width: 5,),
                                        Text('Folder', style: textStyle(20, Colors.black, FontWeight.w600),),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()=> FirebaseService().uploadFile(''),
                                    child: Row(
                                      children: [
                                        Text('Upload', style: textStyle(20, Colors.black, FontWeight.w600),),
                                        SizedBox(width: 5,),
                                        Icon(EvaIcons.upload, color: Colors.grey, size: 30,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                    );
                  },
                  child: FloatingButton(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openAddFolderDialog(context) {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            actionsPadding: EdgeInsets.only(right: 10, bottom: 10),
            title: Text('New Folder', style: textStyle(17, Colors.black, FontWeight.w600),),
            content: TextFormField(
              controller: createFolder,
              autofocus: true,
              style: textStyle(17, Colors.black, FontWeight.w600),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: 'Untitled Folder',
                hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
              ),
            ),
            actions: [
              InkWell(
                onTap: ()=> Get.back(),
                child: Text('Cancel', style: textStyle(16, textColor, FontWeight.bold),),
              ),
              InkWell(
                onTap: (){
                  userCollection.doc(FirebaseAuth.instance.currentUser!.uid).
                  collection('folders').add({
                    'name': createFolder.text,
                    'time': DateTime.now(),
                  });
                  Get.offAll(NavScreen());
                },
                child: Text('Create', style: textStyle(16, textColor, FontWeight.bold),),
              ),
            ],
          );
        }
    );
  }
}